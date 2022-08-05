class AddCommentIdToLikeable < ActiveRecord::Migration[7.0]
  def change
    add_column :likeables, :comment_id, :integer
  end
end
