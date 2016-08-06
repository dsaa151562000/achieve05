class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    #ログインユーザーが通知受信者であること。 通知作成順にソートすること。 blogのコメントが含まれている
    #@notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:topic]})
    #binding.pry
    
    #お知らせ一覧表示時に未読、既読のステータスを更新する処理を定義します。
    @notifications.update_all(read: true)
  end
end
