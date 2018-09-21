namespace :collect_data do
  desc "TODO"
  task scrape: :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    Rails.logger.info "RakeTaskCollectDataPerformingAt #{Time.now}"
    ScrapesController.new.clear_all_data
    ScrapesController.new.index
  end

  desc "CleanRunData"
  task clean: :environment do
    Run.all.each do |run|
      run.destroy! unless (Result.where(run_id: run.id).any? || Milestone.where(run_id: run.id).any?)
      Rails.logger.info "RakeRunsCleaningTaskRunningAt #{Time.now}"
    end
  end

  desc 'CleanMilestones'
  task clean_milestones: :environment do
    Milestonecleaner.perform
    Rails.logger.info "RakeMilstonesCleangingTaskRunningAt #{Time.now}"
  end
end
