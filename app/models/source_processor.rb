class SourceProcessor
  include ScrapesHelper
  include Browserchoice

  def self.perform
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
    agent.user_agent_alias = Browserchoice::Browserchoices.random_alias
    begin
      doc = agent.get(scrape_index_source)
    rescue StandardError => e
      Rails.logger.debug "Error in scraping source, #{e}"
      Resque.enqueue(Alerter::MailGunAlerter, "Scrapes Controller Failed to get Source error: #{e}")
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
      slink.sub! 'localhost', '127.0.0.1' if Rails.env.development? || Rails.env.test?
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
  end
end