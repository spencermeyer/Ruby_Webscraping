class Alerter
  class MailGunAlerter
    require 'mailgun-ruby'

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
      mg_client = Mailgun::Client.new(ENV['MAILGUNAPIKEY'])

      parameters  = {
        :to      => ENV['PARKCOLLECTORMAILTARGET'],
        :subject => "An Alert: #{@message}",
        :text    => 'Alerter Alert!',
        :from    => 'postmaster@parkcollectoronrails.co.uk'
      }

      mg_client.send_message 'parkcollectoronrails.co.uk', parameters
    end
  end

  class LinuxSendMail
    @queue = :email_alert_sendmail

    def initializs(message)
      @message = message
    end

    def self.perform(message)
      # `echo "Subject: 'Awooga' | sendmail #{ENV['PARKCOLLECTORMAILTARGET']} -f 'bounces@parkcollectoronrails.co.uk' " `
      `sendmail -t -i -f 'bounces@parkcollectoronrails.co.uk' target_insert_here@somewhere.com << EOF`
      `From: ParkAlerter`
      `Subject: APA "#{meessage}"`
      `EOF`
      # WIP
    end
  end

  class Loggeronly
    @queue = :loggeronly

    def initialize(message)
      @message = message
    end

    def self.perform(message)
      Rails.logger.debug "FROM THE ALERTER #{@message}"
    end
  end

  class SlackAlerter
    require 'slack-notifier'

    def initialize(message)
      @message = message
    end

    def perform    
      notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
      notifier.ping text: "#{@message}"
    end
  end
end
