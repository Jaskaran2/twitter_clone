class Tweet < ApplicationRecord
  include NotificationHelper
  include BroadcastTweetHelper
  include Chunkable

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :chunks, as: :chunkable, dependent: :destroy

  belongs_to :parent_tweet, class_name: 'Tweet', foreign_key: 'parent_tweet_id',optional: true
  has_many :child_tweets, class_name: 'Tweet', foreign_key: 'parent_tweet_id',dependent: :destroy

  has_many :retweets, -> { where(tweet_type: "retweet") } ,class_name:'Tweet',foreign_key: 'parent_tweet_id',dependent: :destroy
  has_many :replies, -> { where(tweet_type: "reply") } ,class_name:'Tweet',foreign_key: 'parent_tweet_id',dependent: :destroy

  # Select tweets.* from tweets where tweets.tweet_type="reply" and tweets.parent_tweet_id= 75

  validates :body,presence: true,unless: :parent_tweet_id

  has_one_attached :tweet_image

  has_many :impresseions,dependent: :destroy
  has_many :visiting_users, through: :impresseions,source: :user

  scope :followers_tweets,->(currentUser){ where(user_id: currentUser.following.ids << currentUser.id) }

  # scope :my_tweets,->(currentUser){ where(user_id: currentUser)}

  scope :get_replies,->(id){ where(parent_tweet_id: id) }

  scope :recent,->{ order("created_at DESC") }

  after_destroy_commit{ broadcast_remove_to "public_tweets" } 

  after_create_commit :send_retweet_reply_notification,if: Proc.new{ tweet_type == "retweet" or tweet_type == "reply" }

  after_create_commit :broadcast_tweet_retweet


  def set_visitor(user)   
    Impresseion.find_or_create_by(tweet_id: self.id,user_id: user.id)
  end

  def send_retweet_reply_notification
    notification = Notification.create(recipient:  self.parent_tweet.user, actor: self.user, action: self.tweet_type, notifiable: self)
    NotificationRelayJob.perform_later(notification)
    notify(notification)
  end

  def broadcast_tweet_retweet
    if self.tweet_type == "tweet"
      broadcastTweet(self)
    elsif self.tweet_type == "retweet"
      broadcastRetweet(self)
    end
  end
end
