class PagesController < ApplicationController
  
  def welcome
    @user = User.new
  end
  
  def optional
    
  end
  
end
