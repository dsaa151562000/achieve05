require 'rails_helper'

describe Topic do
  # タイトルがあれば有効な状態であること
    it "is valid with title" do
         #topic = Topic.new(title: '東京', content: '暑いです')
         topic = Topic.new(content: '暑いです')
         expect(topic).to be_valid
     end

  #タイトルがなければ無効であること
  it "is invalid without a title" do
          topic = Topic.new
         expect(topic).not_to be_valid
  end
  
   #タイトルがなければ無効であること
  it "is valid with title" do
    topic = Topic.new
    topic.valid?
    expect(topic.errors[:title]).to include("を入力してください")
  end
end