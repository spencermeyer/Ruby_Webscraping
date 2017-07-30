class ScrapesController < ApplicationController
  #before_action :set_scrape, only: [:show, :edit, :update, :destroy]
  before_action :clear_all_data

  # GET /scrapes
  # GET /scrapes.json
  def index
    Rails.logger.info "AWOOGA start scrape at #{Time.now}"
    #SET STUFF UP
    require 'open-uri'
    require 'mechanize'
    online_url_for_scrape = 'http://www.parkrun.com/results/consolidatedclub/?clubNum=1537'
    local_url_for_scrape =  'http://localhost:4567/results_Consolidated_parkrun.html'

    if (Rails.env.development? | Rails.env.test?)
     scrape_index_source = local_url_for_scrape
    else
      scrape_index_source = online_url_for_scrape
    end

    # START TO GET THE INDEX PAGE
    browser = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
    agent=Mechanize.new
    agent.user_agent_alias = "Mac Safari"
    doc = agent.get(scrape_index_source)
    mech_links_for_scraping = doc.xpath('//a[contains(text(),"View full results")]')
    @links_for_scraping = []
    mech_links_for_scraping.each do |link|
      @links_for_scraping.push(link.attributes['href'].value)
      @links_for_scraping.first.destroy
    end

    # GET THE DATA FROM THE INDIVIDUAL LINKS
    @data = []
    @links_for_scraping.each do | slink |    #This is the scrape for each individual link******
      if (Rails.env.development? | Rails.env.test?)
        run_identifier = Run.find_or_create_by(run_identifier: slink[slink.index('4567')+5 .. slink.index('/results')-1])
        Rails.logger.info "Development The Link is: #{run_identifier.run_identifier} "
      else
        run_identifier = slink[slink.index('parkrun') .. slink.index('/results')-1]
        run_identifier = run_identifier[run_identifier.index('/')+1..run_identifier.length]
        run_identifier = Run.find_or_create_by(run_identifier: run_identifier)
        Rails.logger.info "Production The Link is: #{run_identifier.run_identifier} "
      end
      agent = Mechanize.new
      agent.user_agent_alias = "Mac Safari"
      slink_doc = agent.get(slink)
      slink_doc.xpath('//tr').each do |row|  # this is the loop for individual rows of data.
        if row.children.length > 8  && row.children[0].children.text != '' && (!row.children[1].children.text.include? 'parkrunner')
            result = Result.create(
              pos:            row.children[0].children.text,
              parkrunner:     row.children[1].children.text,
              time:           row.children[2].children.text,
              age_cat:        row.children[3].children.text,
              age_grade:      row.children[4].children.text,
              gender:         row.children[5].children.text,
              gender_pos:     row.children[6].children.text,
              club:           row.children[7].children.text,
              note:           row.children[8].children.text,
              total:          row.children[9].children.text,
              run_id:         run_identifier.id,
              athlete_number: get_runner_number_from_text(row) || nil
              )
            if ([49, 99, 149, 199, 249, 299, 349, 399, 449, 499, 549, 599, 649].include? result.total) && (run_identifier.run_identifier.include? 'astleigh' or result.club.include? 'astleigh')
              milestone = Milestone.find_or_create_by(result.attributes.except('id', 'created_at', 'updated_at'))
              Rails.logger.info "AWOOGA should create milestone, #{result.parkrunner}"
            elsif  [9].include? result.total && (result.age_cat.include? 'J')
              milestone=Milestone.find_or_create_by(result.attributes.except('id', 'created_at', 'updated_at'))
            elsif ([10, 50, 100, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650].include? result.total)
              result_to_clear = Milestone.find_by athlete_number: result.athlete_number if Milestone.exists?(:athlete_number => result.athlete_number)
              if(result_to_clear)
                Rails.logger.debug "AWOOGA destroying milestone, #{result_to_clear.parkrunner}"
                result_to_clear.destroy
              end
            end
        end   # here ends each row operation
      end # here ends the slink each
    end  # here ends each link for scraping

    # now would be a good time to assign age grade positions.
    @runs = Run.all
    @runs.each do |run|
      Rails.logger.info "ok lets assign AGE GRADES sort run #{run.run_identifier}"
      @results_for_sorting = Result.where(run_id: run.id).order('age_grade DESC')
      @results_for_sorting.each_with_index do |res, index|
        #puts "SORTED: #{res.age_grade}, #{res.parkrunner}, #{res.pos}, #{res.run_id}, #{index+1}"
        res.age_grade_position = index+1
        res.save
      end
    end
    # and now we assign positions within an age category
    @runs.each do |run|
      Rails.logger.info "ok lets assign AGE CAT POS for run #{run.run_identifier}"
      cats=[]
      Result.all.each { |res| cats.push(res.age_cat) }
      cats=cats.uniq
      cats.each do |catz|
        @results_for_sorting_by_age_cat = Result.where(run_id: run.id, age_cat: catz).order('time ASC')
        @results_for_sorting_by_age_cat.each_with_index do |res, index|
          res.age_cat_position = index +1
          res.save
        end
      end
    end
    Rails.logger.info "AWOOGA finished scraping at #{Time.now}"
    Rails.logger.info "AWOOGA about to redirect"
    redirect_to :results unless request.nil?
  end

  def get_runner_number_from_text(inputrow)
    runnerstring = inputrow.children[1].children.text
    if (runnerstring.include? 'Unknown')
      return nil
    else
      athletestring = inputrow.children[1].children[0].attributes['href'].try(:value)
      athlete_number = athletestring[athletestring.index('ber=')+4, athletestring.length].to_i
      return athlete_number
    end
  end

  # GET /scrapes/1
  # GET /scrapes/1.json
  def show
  end

  # GET /scrapes/new
  def new
    @scrape = Scrape.new
  end

  # GET /scrapes/1/edit
  def edit
  end

  # POST /scrapes
  # POST /scrapes.json
  def create
    @scrape = Scrape.new(scrape_params)

    respond_to do |format|
      if @scrape.save
        format.html { redirect_to @scrape, notice: 'Scrape was successfully created.' }
        format.json { render :show, status: :created, location: @scrape }
      else
        format.html { render :new }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrapes/1
  # PATCH/PUT /scrapes/1.json
  def update
    respond_to do |format|
      if @scrape.update(scrape_params)
        format.html { redirect_to @scrape, notice: 'Scrape was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrape }
      else
        format.html { render :edit }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapes/1
  # DELETE /scrapes/1.json
  def destroy
    @scrape.destroy
    respond_to do |format|
      format.html { redirect_to scrapes_url, notice: 'Scrape was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def clear_all_data
      #ActiveRecord::Base.connection.execute("TRUNCATE runs RESTART IDENTITY")
      Run.last.touch(:updated_at) unless !Run.any?
      Result.destroy_all
      ActiveRecord::Base.connection.execute("TRUNCATE results RESTART IDENTITY")
    end

    def set_scrape
      @scrape = Scrape.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_params
      params.require(:scrape).permit(:nullfield)
    end
end
