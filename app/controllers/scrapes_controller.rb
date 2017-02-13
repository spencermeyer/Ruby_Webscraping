class ScrapesController < ApplicationController
  #before_action :set_scrape, only: [:show, :edit, :update, :destroy]
  before_action :clear_all_data

  # GET /scrapes
  # GET /scrapes.json
  def index
    #@scrapes = Scrape.all
    #SET STUFF UP
    require 'open-uri'
    online_url_for_scrape = 'http://www.parkrun.com/results/consolidatedclub/?clubNum=1537'
    local_url_for_scrape =  'http://localhost:8000/results_Consolidated_parkrun.html'

    if Rails.env.development?
      scrape_index_source = local_url_for_scrape
    else
      scrape_index_source = online_url_for_scrape
    end

    # START TO GET THE INDEX PAGE
    #headers={ :accept => '*/*', :referer => 'https://www.google.co.uk/', :user-agent => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36' }
    browser = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
    doc = Nokogiri::HTML(open(scrape_index_source), browser)
    nok_links_for_scraping = doc.xpath('//a[contains(text(),"View full results")]')
    @links_for_scraping = []
    nok_links_for_scraping.each do |link|
      puts "**** and the scrape link is #{link.attributes['href'].value}"
      @links_for_scraping.push(link.attributes['href'].value)
    end

    # GET THE DATA FROM THE INDIVIDUAL LINKS
    @data = []
    @links_for_scraping.each do | slink |
      run_identifier = Run.create(run_identifier: slink[slink.index('results_')+8 .. slink.index('_parkrun_')-1 ])
      slink_doc = Nokogiri::HTML(open(slink))
      slink_doc.xpath('//tr').each do |row|
        if row.children.length > 8  && row.children[0].children.text != '' && row.children[1].children.text != 'parkrunner'
            result = Result.create(
              pos: row.children[0].children.text,
              parkrunner: row.children[1].children.text,
              time: row.children[2].children.text,
              age_cat: row.children[3].children.text,
              age_grade: row.children[4].children.text,
              gender: row.children[5].children.text,
              gender_pos: row.children[6].children.text,
              club: row.children[7].children.text,
              note: row.children[8].children.text,
              total: row.children[9].children.text,
              run_id: run_identifier.id
              )
         end 
      end
    end

    # now would be a good time to assign age grade positions.
    @runs = Run.all
    @runs.each do |run|
      puts "ok lets sort run #{run.run_identifier}"
      @results_for_sorting = Result.where(run_id: run.id).order('age_grade DESC')
      @results_for_sorting.each_with_index do |res, index|
        #puts "SORTED: #{res.age_grade}, #{res.parkrunner}, #{res.pos}, #{res.run_id}, #{index+1}"
        res.age_grade_position = index+1
        res.save
      end
    end
    # and now we assign positions within an age category
    @runs.each do |run|
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
    redirect_to :results
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
      @runs = Run.all
      if @runs.any?
        @runs.each { |run| run.destroy }
      end
      @results = Result.all
      if @results.any?
        @results.each { |result| result.destroy }
      end
    end

    def set_scrape
      @scrape = Scrape.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_params
      params.require(:scrape).permit(:nullfield)
    end
end
