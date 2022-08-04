class Likeable < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :comment
end
