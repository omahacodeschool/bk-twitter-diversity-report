class UsersController < ApplicationController
  
  def index
    @users=User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    @user=User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: "Your demographics have been saved."
    else
      render "edit"
    end
  end
  
end
