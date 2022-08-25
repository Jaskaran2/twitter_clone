class Tweet < ApplicationRecord
  belongs_to :user

  belongs_to :parent_tweet, class_name:"Tweet", foreign_key: 'parent_tweet_id', optional: true
  
  has_many :child_tweets, class_name:"Tweet",foreign_key: 'parent_tweet_id'
  
  #has many retweets

  has_many :likes,as: :likeable

  validates :body,presence: true,unless: :parent_tweet_id

  has_one_attached :tweet_image

  scope :followers_tweets,->{where(user_id: Current.user.following)}

  scope :get_replies,->(id){where(parent_tweet_id: id).order("created_at DESC")}

  after_destroy_commit{broadcast_remove_to "public_tweets"}

end
