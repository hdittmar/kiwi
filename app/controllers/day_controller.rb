class DayController < ApplicationController
  def index
    @date = Date.parse(params[:day])
    @devices = Device.get_most_popular(@date) || []
  end
end
