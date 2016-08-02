class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  
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
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_path(@comment.topic), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js{ render :index,  notice: 'Comment was successfully destroyed.' }
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
    
end
