class UsersController < ApplicationController
 before_action :authenticate_user!
  
  def index
    @users = User.all
    
    #自分がフォローしている人を取得
    @my_followed_users =current_user.followed_users.ids
    #binding.pry
    
    #自分をフォローしている人を取得
    @my_followers=current_user.followers.ids
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
    
     #自分がフォローしている人を取得
    @my_followed_users =current_user.followed_users.ids
    @my_followed_users2 =current_user.followed_users
    #binding.pry
    
    #自分をフォローしている人を取得
    @my_followers=current_user.followers.ids
    @my_followers2=current_user.followers
    
    @flag= @user.in?(@my_followed_users2) 
    @flag2= @user.in?(@my_followers2) 
    
    #binding.pry
    
    @we = Relationship.followed_follower(current_user,@user)
   

  end
  
end
