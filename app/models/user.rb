class User < ApplicationRecord
  include NotificationHelper
  include LikeBroadcastHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tweets, dependent: :destroy
 

  has_many :likes,dependent: :destroy
  #user.liked_tweets shows tweets user has liked
  has_many :liked_tweets,through: :likes,source: :tweet

  has_many :active_friendships,class_name:"Friendship",foreign_key:"follower_id",dependent: :destroy
  has_many :following, through: :active_friendships,source: :followed
  has_many :passive_friendships,class_name:"Friendship",foreign_key:"followed_id",dependent: :destroy
  has_many :followers, through: :passive_friendships,source: :follower
  
  has_many :notifications,foreign_key: :recipient_id


  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  

  #follow/unfollow
    def follow(user)
      active_friendships.create(followed_id: user.id) 
    end
  
    def unfollow(user)
      active_friendships.find_by(followed_id: user.id).destroy
    end
  
    def following?(user)
      following.include?(user)
    end


    #like unlike tweets
    def like(tweet)
      liked_tweets<<tweet
      like_broadcast(tweet)
    end 
      

    def unlike(tweet)    
      liked_tweets.destroy(tweet)
      like_broadcast(tweet)
    end

    def liked?(tweet)
      liked_tweets.include?(tweet)
    end

end
