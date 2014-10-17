class PagesController < ApplicationController
  
  def welcome
    @report=Report.new
  end
  
  def optional
  end
  
end
