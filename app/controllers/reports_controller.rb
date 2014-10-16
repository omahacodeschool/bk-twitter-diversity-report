class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def show
    @user = User.find_by_name(params[:name])
    # @report = Report.find_by_id(params[:id])
    
  end
end
