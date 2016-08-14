class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    #自分がフォローしている人を取得
    @my_followed_users2 =current_user.followed_users
    #自分をフォローしている人を取得
    @my_followers2=current_user.followers
    
    #送られてきたパラメータを元に、フォローしたいユーザを取得
    @user = User.find(params[:relationship][:followed_id])
    #ユーザをフォロー
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    #自分がフォローしている人を取得
    @my_followed_users2 =current_user.followed_users
    #自分をフォローしている人を取得
    @my_followers2=current_user.followers
    
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
