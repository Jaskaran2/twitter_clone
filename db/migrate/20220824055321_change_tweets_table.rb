class ChangeTweetsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweets, :tweet_id, :parent_tweet_id
    add_column :tweets, :tweet_type, :string
  end
end
