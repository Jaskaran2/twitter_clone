class AddDefaultColValueToTweet < ActiveRecord::Migration[7.0]
  def change
    change_column :tweets, :tweet_type, :string, default: "tweet"
  end
end
