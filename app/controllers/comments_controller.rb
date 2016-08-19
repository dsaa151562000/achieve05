class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  #コメント作成後にPusher送信処理を実行する。
  after_action :sending_pusher, only: [:create]
  
  # GET /comments/1/edit
  def edit
    @edit = true
  end
  
   # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to topic_path(@comment.topic_id), notice: '更新いたしました。' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    #コメント投稿時にNotificationを作成
    #@notification = @comment.notifications.build(recipient_id: @topic.user_id, sender_id: current_user.id)
    #buildメソッドを使用して@commentに紐付けたインスタンスは@comment.save時にセットで保存されます。
    #もしトピックが自分のものにコメントしていたならば
    if @topic.user_id == current_user.id
    #既読済みにする
     @notification = @comment.notifications.build(recipient_id: @topic.user_id, sender_id: current_user.id, read: true)   
    else
    #でなければ未読
     @notification = @comment.notifications.build(recipient_id: @topic.user_id, sender_id: current_user.id)  
    end
    
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        # JS形式でレスポンスを返します。
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def destroy
    #@comment = Comment.find(params[:id])
    @comment2 = current_user
    @user_id= @comment.user.id
    #binding.pry
    respond_to do |format|    
    if @comment2.id == @user_id
     @comment.destroy
      format.html { redirect_to topic_path(@comment.topic), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js{ render :index,  notice: 'Comment was successfully destroyed.' }
    else
           format.html { redirect_to '/assets/501.html' }
    end
      end

  end
  

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    
    def sending_pusher
      Notification.sending_pusher(@notification.recipient_id)
    end
    
end
