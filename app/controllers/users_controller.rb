class UsersController < ApplicationController
  
  def index
    @users=User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def new
    @user=User.new
  end
  
  def create
    gender_array=params[:user][:gender_array].split(" ")
    orientation_array=params[:user][:orientation_array].split(" ")
    @user=User.new(:gender_array => gender_array, :orientation_array => orientation_array)
    if @user.save
      redirect_to "users"
    else
      render "new"
    end
  end
  
end
