module ScrapesHelper
  class UnusedRuns
    @queue = :clear_old_runs
    def self.perform
      Run.all.each do |run|
        run.destroy! unless (Result.where(run_id: run.id).any? || Milestone.where(run_id: run.id).any?)
      end
    end
  end
end