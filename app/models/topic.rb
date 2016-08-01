class Topic < ActiveRecord::Base
    belongs_to :user
    # CommentモデルのAssociationを設定
    has_many :comments, dependent: :destroy
end
