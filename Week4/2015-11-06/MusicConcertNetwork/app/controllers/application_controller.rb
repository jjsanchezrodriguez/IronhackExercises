class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
    @today_concerts = Concert.today_concerts
    @month_concerts = Concert.order(:date).this_month_concerts
  end
end
