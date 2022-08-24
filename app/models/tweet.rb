class Tweet < ApplicationRecord
  belongs_to :user

  belongs_to :parent_tweet,class_name:"Tweet", foreign_key: 'parent_tweet_id', optional: true


  has_many :likes,as: :likeable

  validates :body,presence: true,unless: :parent_tweet_id


  has_one_attached :tweet_image

  

  after_destroy_commit{broadcast_remove_to "public_tweets"}

  before_save :set_tweet_type



  def set_tweet_type
  
    if self.parent_tweet_id? and self.body?
      self.tweet_type="reply"
    elsif self.parent_tweet_id?
      self.tweet_type="retweet"
    elsif !self.parent_tweet_id? and self.body?      
      self.tweet_type="tweet"
    end
  
  end



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

  # def tweet_type 
    
  #   if tweet_id?
  #     "retweet"
  #   elsif tweet_id? and body?
  #     "reply"
  #   else
  #     "tweet"
  #   end
    
  # end

end
