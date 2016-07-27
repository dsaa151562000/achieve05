class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_topic(topic)
    @greeting = "Hi"

    mail to: "suzuki02yo@gmail.com",
    subject: '【NEW Achieve】topicが投稿されました'
  end
end
