class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :comment

  accepts_nested_attributes_for :notifications
end
