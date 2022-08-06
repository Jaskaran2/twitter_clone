class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_one_attached :comment_image
  
  has_many :likes,as: :likeable

end
