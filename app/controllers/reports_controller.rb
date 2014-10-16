class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def show
    @report = Report.find_by_id(params[:id])
    
  end
end
