class UsersController < ApplicationController
  
  def index
    @users=User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def edit
    @user = User.find_by_name(params[:name])
  end
  
  def update
    session[:nickname] = params[:nickname]
    @user=User.find_by_name(params[:name])
    if @user.update_attributes(params[:user])
      redirect_to report_path(@user.name), notice: "Your demographics have been saved. Checkout your report!"
    else
      render "edit"
    end
  end
  
end
