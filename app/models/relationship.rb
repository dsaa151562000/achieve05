class Relationship < ActiveRecord::Base
  #userモデルとのAssociationを設定
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  scope :followed_follower, -> (current_user,user) do
    where("(relationships.follower_id = ? AND relationships.followed_id =?) AND (relationships.followed_id = ? AND  relationships.follower_id =?)", current_user.id,user.id, user.id, current_user)
  end
  
end
