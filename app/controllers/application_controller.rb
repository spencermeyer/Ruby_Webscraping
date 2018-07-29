class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_headers

  def set_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"]        = "no-cache"
    response.headers["Expires"]       = "Mon, 01 Jan 1990 00:00:00 GMT"
  end
end
