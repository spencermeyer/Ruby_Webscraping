class MilestoneCleaner
  include Browserchoice

  require 'single_milestone_clean_delayed_job'
  class MilestoneCleanerError < StandardError; end

  def self.perform
    Rails.logger.info 'Milestones cleaning'
    Milestone.all.each_with_index do |ms, index|
      Resque.enqueue_at(
        Time.now + (index + 10).seconds,
        SingleMileStoneCleanDelayedJob,
        number: ms.athlete_number
        )
    end
  end
end
