class Alerter
  require 'mailgun'
  require 'open-uri'
  require 'httparty'
  require 'rest-client'

  @queue = :email_alert

  def initialize(message)
    @message = message
  end

  def self.perform(message)
    Rails.logger.debug "Alerter will send #{message}"
    begin
      send_simple_message(message)
    rescue StandardError => e
      Rails.logger.debug "alerter problem: #{e}"
    end
  end

  def self.send_simple_message(message_text)
    RestClient.post "https://api:key-#{ENV['MAILGUNAPIKEY']}"\
    "#{ENV['MAILGUNAPIROUTE']}",
    :from => "ParkCollectorAlerter #{ENV['MAILGUNPOSTMASTER']}",
    :to => "#{ENV['PARKCOLLECTORMAILTARGET']}",
    :subject => "ParkCollectorAlert",
    :text => message_text
  end
end
