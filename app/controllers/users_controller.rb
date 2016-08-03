class UsersController < ApplicationController
 before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @followed_users= current_user.followed_users
    @followers=current_user.followers
  end

  def show_user
    @user = User.find(params[:id])
    @followed_users= @user.followed_users  

    @followers=@user.followers
    # binding.pry
  end
  
end
