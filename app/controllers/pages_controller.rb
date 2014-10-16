class PagesController < ApplicationController
  
  def welcome
    
  end
  
  def optional
    session[:nickname] = params[:nickname]
  end
  
end
