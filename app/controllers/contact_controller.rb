class ContactController < ApplicationController
  def index
   @contacts = Contact.all
  end

  def new
    #@contact = Contact.new
    #binding.pry 空の１行が表示
    
     
    if params[:back]
      @contact = Contact.new(contact_params)
    else
      @contact = Contact.new
    end
  end
  
    def confirm
    #raise @contact = Contact.new(contact_params).inspect inspectハッシュが文字列で表示される
    @contact = Contact.new(contact_params)
    #binding.pry
    
    if @contact.valid?
      @msee=@contact.message.gsub(/\r\n|\r|\n/, "<br />").html_safe
    else
      render action: 'new'
    end
  end

  #擬似的なUser2データ構造体を作る
	User2 = Struct.new(:name, :email)
	
  def thanks
    @contact = Contact.create(contact_params)
    
    #User2のインスタンスを作成する
    user = User2.new("name", "suzuki02yo@gmail.com")
  	# deliverメソッドを使って、メールを送信する
    ContactMailer.contact_email(user, @contact).deliver
    
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
