namespace :collect_data do
  desc "TODO"
  task scrape: :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    Rails.logger.info "RakeTaskCollectData awooga"
    ScrapesController.new.clear_all_data
    ScrapesController.new.index
  end

  desc "CleanRunData"
  task clean: :environment do
    Run.all.each do |run|
      run.destroy! unless (Result.where(run_id: run.id).any? || Milestone.where(run_id: run.id).any?)
    end
  end
end
