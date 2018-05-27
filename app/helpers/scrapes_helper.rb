module ScrapesHelper
  class UnusedRuns
    @queue = :clear_old_runs
    def self.perform
      Run.all.each do |run|
        run.destroy! unless (Result.where(run_id: run.id).any? || Milestone.where(run_id: run.id).any?)
      end
    end
  end

  class OtherBrowsers
    ALIASES = 
      [
        'Linux Firefox',
        'Linux Mozilla',
        'Mac Firefox',
        'Mac Mozilla',
        'Mac Safari',
        'Mac Safari',
        'Windows IE 10',
        'Windows IE 11',
        'Windows Edge',
        'Windows Mozilla',
        'Windows Firefox',
      ]
  end
end