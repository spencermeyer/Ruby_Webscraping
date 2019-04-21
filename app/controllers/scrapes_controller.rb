class ScrapesController < ApplicationController
  include ScrapesHelper
  include Browserchoice

  before_action :clear_all_data
  after_action :add_clear_old_runs_to_resque

  def index
    Resque.enqueue(SourceProcessor)
    flash[:info] = "Queued Data Collection at #{Time.now} come back and refresh the page"
    @results = Result.eastleigh_and_stalkees.all.order(run_id: :asc, pos: :asc)
    Rails.logger.info "Finished scraping at #{Time.now} and redirecting"
    redirect_to :results unless request.nil?
  end

  def clear_all_data
    Rails.logger.debug "CLEARING ALL DATA"
    last_run = Run.last
    last_run.updated_at = Time.now unless !last_run
    last_run.save! unless !last_run
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
