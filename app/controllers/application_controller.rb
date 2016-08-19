class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_actionでdeviseのストロングパラメーターにnameカラムを追加するメソッドを実行します。
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :current_notifications
  #ヘッダー通知用
  def current_notifications
    if(signed_in?)#もしサインインしていたなら
     @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:topic]})
    end
  
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
    #@notifications_count = Notification.where(recipient_id: current_user).where.not(sender_id: current_user).order(created_at: :desc).unread.count
    
    #.where.not(user_id: current_user.id)
   #binding.pry
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)
  
  def after_sign_in_path_for(resource)
    topics_path
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end
end
