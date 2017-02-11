class ScrapesController < ApplicationController
  before_action :set_scrape, only: [:show, :edit, :update, :destroy]

  # GET /scrapes
  # GET /scrapes.json
  def index
    @scrapes = Scrape.all
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
    doc = Nokogiri::HTML(open(scrape_index_source))
    nok_links_for_scraping = doc.xpath('//a[contains(text(),"View full results")]')
    @links_for_scraping = []
    nok_links_for_scraping.each do |link|
      puts "**** and the scrape link is #{link.attributes['href'].value}"
      @links_for_scraping.push(link.attributes['href'].value)
    end

    # GET THE DATA FROM THE INDIVIDUAL LINKS
    @data = []
    @links_for_scraping.each do | slink |
      run_identifier = slink[slink.index('results_')+8 .. slink.index('_parkrun_')-1 ]
      slink_doc = Nokogiri::HTML(open(slink))
      slink_doc.xpath('//tr').each do |row|
        row.xpath('//td').each do |cell|
          puts "cell info: #{cell.children.text}"
        end
      end
      # binding.pry


      data_set = [
        {"parkrunner" => "Joe Blogs", "position" => "67", }, {}
      ]
      @data.push({run_identifier => data_set}, 'other_data' => 'like number of men etc')
    end

#  slink_doc.xpath('//tr')[0].xpath('//td')[0]

    binding.pry
    eelsfeastbuckets


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
    def set_scrape
      @scrape = Scrape.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_params
      params.require(:scrape).permit(:nullfield)
    end
end
