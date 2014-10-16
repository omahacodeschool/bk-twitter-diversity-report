class SessionsController < ApplicationController
  def create
   user = User.from_omniauth(env['omniauth.auth'])
   # @token=request.env['omniauth.auth']['credentials']['token']
   # @secret=request.env['omniauth.auth']['credentials']['secret']
   session[:user_id] = user.id
   redirect_to welcome_path, notice: "Signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to welcome_path, notice: "Signed out!"
  end
  
end
