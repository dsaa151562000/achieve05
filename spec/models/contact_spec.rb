require 'rails_helper'

describe 'Contactモデルバリデーションテスト' do

   it "nameの空白は無効" do
     contact = Contact.new(name: nil, email: 'hogehoge@hoge.com',message: 'hogehoge')
     #expect(contact).not_to be_valid
     contact.valid?
     expect(contact.errors[:name]).to include("名前を入力してください")
   end
   
   it "emailの空白は無効" do
     contact = Contact.new(name: 'hoge', email: nil ,message: 'hogehoge')
     contact.valid?
     expect(contact.errors[:email]).to include("メールアドレスを入力してください")
   end
   
   it "messageの空白は無効" do
     contact = Contact.new(name: 'hoge', email: 'hogehoge@hoge.com' ,message: nil)
     contact.valid?
     expect(contact.errors[:message]).to include("お問い合わせ内容を入力してください")
   end

end
