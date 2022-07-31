class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tweets
  has_many :comments, through: :tweet

  has_many :likeables,dependent: :destroy
  #user.liked_tweets shows tweets user has liked
  has_many :liked_tweets,through: :likeables,source: :tweet

  has_many :active_friendships,class_name:"Friendship",foreign_key:"follower_id",dependent: :destroy
  has_many :following, through: :active_friendships,source: :followed
  has_many :passive_friendships,class_name:"Friendship",foreign_key:"followed_id",dependent: :destroy
  has_many :followers, through: :passive_friendships,source: :follower

  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    

  def follow(user)
    active_friendships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_friendships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end


  def liked?(tweet)
   liked_tweets.include?(tweet)
  end

  def like(tweet)
    if liked_tweets.include?(tweet)
      liked_tweets.destroy(tweet)
    else
      liked_tweets<<tweet
    end
    public_target="tweet_#{tweet.id}_public_likes"
    broadcast_replace_later_to "public_likes",
                                target:public_target,
                                partial:"likes/like_count",
                                locals:{tweet:tweet}
  end



end
