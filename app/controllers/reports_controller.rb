class ReportsController < ApplicationController
  def new
    @report = Report.new
  end
  
  def create
    @report=Report.new(:user_name => params[:report][:user_name])
    
    if @report.save
      # For example, @report might be a Report object with {user_name: "sumeetjain"}.
      @report.generate
      session[:redirect_to_report_later] = @report.id
      session[:nickname] = @report.user_name
      binding.pry
      redirect_to optional_path
    else
      redirect_to root_url, :notice => "Your report could not be generated. Be sure to enter valid Twitter username."
    end
    
  end

  def show
    @report=Report.find_by_id(session[:redirect_to_report_later])
    @gender=@report.gender_hash
    @orientations=@report.orientation_hash
    @participation=@report.participation
    session[:redirect_to_report_later] = nil
  end
  
end
