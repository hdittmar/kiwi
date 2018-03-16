class TypeController < ApplicationController
  def show
    @category = params["category"]
    @status = params["status"]
    relevant_devices = Device.where(status: @status, category: @category)
    @reports = Report.where(status: @status).joins(:device).merge( Device.where(category: @category) ).order(:timestamp)
    @reports[0].timestamp
    @today = DateTime.now
  end
end
