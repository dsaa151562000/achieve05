class ContactController < ApplicationController
  def index
   @contacts = Contact.all
  end

  def new
    @contact = Contact.new
    #binding.pry 空の１行が表示
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

  def thanks
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
