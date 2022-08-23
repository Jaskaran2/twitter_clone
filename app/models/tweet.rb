class Tweet < ApplicationRecord
  belongs_to :user

  belongs_to :tweet, optional: true

  has_many :comments,dependent: :destroy

  has_many :likes,as: :likeable

  validates :body,presence: true,unless: :tweet_id


  has_one_attached :tweet_image

  

  after_destroy_commit{broadcast_remove_to "public_tweets"}

  # around_create :test
  # before_validation :hello

  # def test
  #   puts "Before yield"
  #   yield
  #   puts "after yield"
  # end

  # def hello
  #   puts "Testing before validation"
  # end

  def tweet_type 
    
    if tweet_id?
      "retweet"
    elsif tweet_id? and body?
      "reply"
    else
      "tweet"
    end
    
  end

end
