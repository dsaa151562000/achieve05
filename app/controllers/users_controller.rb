class UsersController < ApplicationController
 before_action :authenticate_user!
  
  def index
    @users = User.all
    
    #自分がフォローしている人を取得
    @my_followed_users =current_user.followed_users
    #binding.pry
    
    #自分をフォローしている人を取得
    @my_followers=current_user.followers
  end
  
  # def show
  #   @user = User.find(params[:id])
  #   @followed_users= current_user.followed_users
  #   @followers=current_user.followers
  # end

  def show_user
    @user = User.find(params[:id])
    
    #フォローしている人を取得
    @followed_users= @user.followed_users  

    #フォロワーを取得
    @followers=@user.followers
    # binding.pry
    
  end
  
end
