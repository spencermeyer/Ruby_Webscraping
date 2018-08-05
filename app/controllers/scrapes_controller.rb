class ScrapesController < ApplicationController
  include ScrapesHelper
  require "#{Rails.root}/lib/scrapes/browserchoice"

  # protect_from_forgery except: :index   # todo - remove this and sort the csrf error.

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
    rescue StandardError => e
      Rails.logger.debug "Error in scraping source, #{e}"
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
      LineProcessor.new(slink, Browserchoice::Browserchoices::ALIASES.sample).perform
    end

    # now would be a good time to assign age grade positions.
    @runs = Run.all   # change this to curret runs only   TODO
    @runs.each do |run|
      Rails.logger.info "ok lets assign AGE GRADES sort run #{run.run_identifier}"
      @results_for_sorting = Result.where(run_id: run.id).order('age_grade DESC')
      @results_for_sorting.each_with_index do |res, index|
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
    Rails.logger.info "AWOOGA finished scraping at #{Time.now} and redirecting"
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
