class SourceProcessor
  class JobAlreadyQueuedOrRunningError < StandardError;
    def initialize(msg="job already running")
      super
    end
  end

  @queue = :source_processing

  include ScrapesHelper
  include Browserchoice

  def self.perform
    require 'open-uri'
    require 'mechanize'

    raise JobAlreadyQueuedOrRunningError if job_already_running_or_queued?

    Result.delete_all

    online_url_for_scrape = 'http://www.parkrun.com/results/consolidatedclub/?clubNum=1537'
    local_url_for_scrape =  'http://127.0.0.1/results/consolidatedclub/index.html'

    if (Rails.env.development? | Rails.env.test?)
      scrape_index_source = local_url_for_scrape
    else
      scrape_index_source = online_url_for_scrape
    end

    # START TO GET THE INDEX PAGE
    Rails.logger.debug "SP: Scraping in mode #{Rails.env}, Source is #{scrape_index_source} Time is #{Time.now}"
    agent = Mechanize.new
    agent.user_agent_alias = Browserchoice::Browserchoices.random_alias
    begin
      doc = agent.get(scrape_index_source)
      Resque.enqueue(Alerter::MailGunAlerter, "SP: Success getting Source for Parkcollector")
    rescue StandardError => e
      Rails.logger.debug "SP: Error in scraping source, #{e}"
      Resque.enqueue(Alerter::SlackAlerter, "SP: Scrapes Failed to get Source error: #{e}")
    end

    mech_links_for_scraping = doc.xpath('//a[contains(text(),"View full results")]') unless !doc
    mech_links_for_scraping ||= []  # in case its failed.
    @links_for_scraping = []
    mech_links_for_scraping.each do |link|
      @links_for_scraping.push(link.attributes['href'].value)
    end

    # GET THE DATA FROM THE INDIVIDUAL LINKS
    @data = []
    @links_for_scraping.each_with_index do | slink, index |
      # slink.sub! 'http://www.parkrun.org.uk', '127.0.0.1' if Rails.env.development? || Rails.env.test?
      # slink.sub! 'runSeqNumber=', 'index.html?' if Rails.env.development? || Rails.env.test?
      # DO NOT NEED TO DO THIS WITH HOSTS FILE TO GO LOCAL.  :)

      Resque.enqueue_at(
        Time.now + (index * 15).seconds,
        LineProcessor,
        args_hash: {
          slink: slink,
          browser: Browserchoice::Browserchoices.random_alias}
        )
      Resque.enqueue_at(
        Time.now + (index * 10).seconds,
        Alerter::Loggeronly,
          message: "ALERTER DELAYED index is #{index}"
        )
    end
    # add in stalkees sources
    Resque.enqueue_at(
      Time.now + (@links_for_scraping.length * 15).seconds + 10.seconds,
      StalkeeProcessor
    )

  end

  private

  def self.job_already_running_or_queued?
    job_already_queued? || job_already_running?
  end

  def self.job_already_running?
    Resque.working.count { |worker| worker.job['payload']['class']==self.name  } > 1
  end

  def self.job_already_queued?
    Resque.redis.lrange("queue:#{scheduled_queue_name}", 0, -1).any? { |job| Resque.decode(job)['class'] == self.name }
  end

  def self.scheduled_queue_name
    resque_schedule[resque_schedule.keys.find { |k| resque_schedule[k]['class']==self.name }]['queue']
  end

  def self.resque_schedule
    Resque.schedule
  end
end