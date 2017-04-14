namespace :collect_data do
  desc "TODO"
  task scrape: :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get "/scrapes"
    puts "Hello from the rake task"
    Rails.logger.debug "AWOOGA from the rake task"
  end
end
