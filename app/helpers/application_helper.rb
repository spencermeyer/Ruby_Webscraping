module ApplicationHelper
  def athlete_online_route(athlete_number)
    'http://www.parkrun.org.uk/eastleigh/results/athletehistory/?athleteNumber=' + athlete_number.to_s
  end
end
