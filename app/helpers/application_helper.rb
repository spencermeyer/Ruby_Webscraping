module ApplicationHelper
  def convert_integer_time_to_hours_mins_seconds(input)
    hours = input/3600
    minutes = (input- hours*3600)/60
    seconds = (input -(hours*3600) -(minutes*60))
    seconds = seconds < 10 ? "0#{seconds}" : seconds 
    "#{hours > 0 ? hours.to_s+':' : ''}#{minutes}:#{seconds}"
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