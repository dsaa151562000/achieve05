class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    #送られてきたパラメータを元に、フォローしたいユーザを取得
    @user = User.find(params[:relationship][:followed_id])
    #ユーザをフォロー
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
