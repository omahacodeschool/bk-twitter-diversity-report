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
    @user=User.new(params[:user])
    if @user.save
      redirect_to "index"
    else
      render "new"
    end
  end
  
end
