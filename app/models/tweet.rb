class Tweet < ApplicationRecord
  belongs_to :user

  belongs_to :tweet, optional: true

  has_many :comments,dependent: :destroy

  has_many :likes,as: :likeable

  validates :body,presence: true,unless: :tweet_id


  has_one_attached :tweet_image


  def tweet_type
    if tweet_id?
      "retweet"
    else
      "tweet"
    end
  end
end
