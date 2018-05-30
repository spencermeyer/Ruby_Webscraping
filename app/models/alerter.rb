class Alerter
  require 'mailgun'
  require 'open-uri'
  require 'httparty'
  require 'rest-client'

  @queue = :email_alert

  def self.perform(run)
    Rails.logger.debug "Hello from the alerter, the problem is:#{run}"
    begin
      send_simple_message(run)
    rescue StandardError => e
      Rails.logger.debug "alerter problem: #{e}"
    end
  end

  def self.send_simple_message(result)
    RestClient.post "https://api:key-#{ENV['MAILGUNAPIKEY']}"\
    "#{ENV['MAILGUNAPIROUTE']}",
    :from => "ParkCollectorAlerter #{ENV['MAILGUNPOSTMASTER']}",
    :to => "#{ENV['PARKCOLLECTORMAILTARGET']}",
    :subject => "ParkCollectorAlert for #{result}",
    :text => "Park Collector Failed to get data for this run."
  end
end
