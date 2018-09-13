class VisitTrimmer

  @queue = :visit_trimmer

  def self.perform
    Visit.first(Visit.count-250).each do |visit|
      visit.destroy
    end
  end
end