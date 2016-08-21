class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    
    #自分がフォローしている人を取得
    @my_followed_users2 =current_user.followed_users
    #自分をフォローしている人を取得
    @my_followers2=current_user.followers
    
    
  end

  # GET /topics/1
  # GET /topics/1.json
  
  def show
    @comment = @topic.comments.build
    #binding.pry
    @comments = @topic.comments
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json

  def create
    #@topic = Topic.new(topic_params)
    @topic = current_user.topics.build(topic_params)
    respond_to do |format|
      if @topic.save
        #redirect_to topics_path, notice: "ブログを作成しました！"
        NoticeMailer.sendmail_blog(@topic).deliver
        format.html { redirect_to @topic, notice: '新しいトピックを作成しました。' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'トピックを更新しました。' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy

    @user_id= @topic.user.id
    @topic2 = current_user
    respond_to do |format| 
    if @topic2.id == @user_id
    #binding.pry
       @topic.destroy
      format.html { redirect_to topics_path(@topic), notice: 'トピックを削除しました。' }
      format.json { head :no_content }
    else
      format.html { redirect_to '/assets/501.html' }
    end
  end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content)
    end
end
