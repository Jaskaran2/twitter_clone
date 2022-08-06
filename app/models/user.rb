class User < ApplicationRecord
  include NotificationHelper
  include LikePost
  include FollowUser
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes,dependent: :destroy
  #user.liked_tweets shows tweets user has liked
  has_many :liked_tweets,through: :likes,source_type: "Tweet",source: :likeable
  has_many :liked_comments,through: :likes,source_type: "Comment",source: :likeable

  has_many :active_friendships,class_name:"Friendship",foreign_key:"follower_id",dependent: :destroy
  has_many :following, through: :active_friendships,source: :followed
  has_many :passive_friendships,class_name:"Friendship",foreign_key:"followed_id",dependent: :destroy
  has_many :followers, through: :passive_friendships,source: :follower
  
  has_many :notifications,foreign_key: :recipient_id

  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
