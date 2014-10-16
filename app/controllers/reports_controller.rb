class ReportsController < ApplicationController
  def new
    @report = Report.new
  end
  
  def create
    @report=Report.new(params[:user_name])
    
    if @report.save
      # For example, @report might be a Report object with {user_name: "sumeetjain"}.
      @report.generate
      session[:redirect_to_report_later] = @report.id
      redirect_to "interstitial_page"
    else
      # TODO
    end
  end

  def show
    @report=Report.find_by_user_name(params[:user_name])
  end
  
end
