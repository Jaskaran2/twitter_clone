class Comment < ApplicationRecord
  belongs_to :user
  
  belongs_to :tweet

  belongs_to :comment,optional: true

  has_one_attached :comment_image
  
  has_many :likes,as: :likeable

  def comment_type
    if comment_id?
      "recomment"
    else
      "comment"
    end
  end

end
