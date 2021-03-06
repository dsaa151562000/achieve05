class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  
  # TopicモデルのAssociationを設定  
  has_many :topics, dependent: :destroy
  
  # CommentモデルのAssociationを設定
  has_many :comments, dependent: :destroy
  
  # RelationshipモデルとAssociationを設定
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  
  #「自分」と「自分”が”フォローしている人」の1対多の関係性を「followed_users」
  has_many :followed_users, through: :relationships, source: :followed
  #「自分」と「自分”を”フォローしている人」の関係性を「followers」
  has_many :followers, through: :reverse_relationships, source: :follower
  
  #指定のユーザをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  #フォローしている、フォローされている
  def followed_follower(current_user,other_user)
    relationships.where(followed_id: current_user.id).where(follower_id: other_user.id)
  end
  
  # scope :followed_follower, -> (current_user,user_id) do
  #   relationships.where(followed_id: current_user.id).where(follower_id: other_user.id)
  # end

  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  

  
   def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20],
      )
      user.skip_confirmation!
      user.save
    end
    user
  end
  
   def self.create_unique_string
    SecureRandom.uuid
  end
  
  mount_uploader :avatar, AvatarUploader
  
end
