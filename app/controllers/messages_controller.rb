class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    #会話にひもづくメッセージを取得する
    @messages = @conversation.messages
    #もしメッセージの数が10よりも大きければ、
      if @messages.length > 10
        #10より大きいというフラグを有効にしてメッセージを最新の10に絞ることをする
         @over_ten = true
         @messages = @messages[-10..-1]
    　end
    　
    　#そうでなければ10より大きいというフラグを無効にして、会話にひもづくメッセージをすべて取得する
    　if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end
      
      #もしメッセージが最新（最後）のメッセージで
      #lastメソッドは、配列の最後の要素を返し空のときはnilを返す、というRubyのメソッドです。
      if @messages.last
        #且つユーザIDが自分（ログインユーザ）であれば、その最新（最後）のメッセージを既読にする
        if @messages.last.user_id != current_user.id
           @messages.last.read = true
         end
       end
       
       #新規投稿のメッセージ用の変数を作成する
       @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
     end
  end
  
  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
