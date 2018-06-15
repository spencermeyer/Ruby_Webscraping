class ScrapesController < ApplicationController
  include ScrapesHelper
  require "#{Rails.root}/lib/scrapes/browserchoice"

  before_action :clear_all_data
  after_action :add_clear_old_runs_to_resque

  def index
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
    Rails.logger.debug "Scraping in mode #{Rails.env}, Source is #{scrape_index_source} Time is #{Time.now}"
    agent = Mechanize.new
    agent.user_agent_alias = Browserchoice::Browserchoices::ALIASES.sample  #use a random alias :)

    begin
      doc = agent.get(scrape_index_source)
      flash[:message] = "Success getting index page at #{Time.now}"
    rescue StandardError => e
      Rails.logger.debug "Error in scraping source, #{e}"
      Resque.enqueue(Alerter::MailGunAlerter, "Scrapes Controller Failed to get Source")
      flash[:message] = "Could not get data: problem was #{e}"
    end

    mech_links_for_scraping = doc.xpath('//a[contains(text(),"View full results")]') unless !doc
    mech_links_for_scraping ||= []  # in case its failed.
    @links_for_scraping = []
    mech_links_for_scraping.each do |link|
      @links_for_scraping.push(link.attributes['href'].value)
    end

    # GET THE DATA FROM THE INDIVIDUAL LINKS
    @data = []
    @links_for_scraping.each do | slink |   #This is the scrape for each individual link
      LineProcessor.new(slink, OtherBrowsers::ALIASES.sample).process
    end

    Rails.logger.info "AWOOGA finished scraping at #{Time.now} and redirecting"
    @results = Result.eastleigh_and_stalkees.all.order(run_id: :asc, pos: :asc)

    redirect_to :results unless request.nil?
  end

  # private  # rake task cannot do private :(
    def clear_all_data
      Rails.logger.debug "CLEARING ALL DATA"
      last_run = Run.last
      last_run.updated_at = Time.now unless !last_run
      last_run.save! unless !last_run
      Result.delete_all
      ActiveRecord::Base.connection.execute("TRUNCATE results RESTART IDENTITY")
    end

    def add_clear_old_runs_to_resque
      Resque.enqueue(UnusedRuns)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_params
      params.require(:scrape).permit(:nullfield)
    end
end
