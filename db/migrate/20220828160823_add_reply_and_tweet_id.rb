class AddReplyAndTweetId < ActiveRecord::Migration[7.0]
  def change
    rename_column  :tweets, :parent_tweet_id, :reply_id
    add_column :tweets, :retweet_id,:integer
  end
end
