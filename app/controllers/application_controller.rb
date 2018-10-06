class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :record_vistor_information

  def record_vistor_information
    if request.ip && request.user_agent
      visit=Visit.new(ip_address: request.ip, browser: request.user_agent)
      visit.save
    end
  end
end
