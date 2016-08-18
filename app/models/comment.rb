class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :comment

  accepts_nested_attributes_for :notifications
  
  scope :comment_topic_not_me, -> (topic_id,user_id) do
      Comment.where(topic_id: topic_id).where.not(user_id: user_id).last
  end
  
  scope :comment_topic, -> (topic_id,user_id) do
      Comment.find_by(topic_id:  topic_id, user_id: user_id)
  end
  
  
end
