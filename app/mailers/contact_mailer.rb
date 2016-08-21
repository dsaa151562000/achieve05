class ContactMailer < ApplicationMailer
    
  def contact_email(user, post)
    @message= post.message
    mail to: user.email, subject: @message
  end
  
end
