namespace :collect_data do
  desc "TODO"
  task scrape: :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    ScrapesController.new.index
    Rails.logger.info "AWOOGA from the rake task"
  end
end
