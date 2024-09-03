class Post < ApplicationRecord
  belongs_to :user
  belongs_to :landmark
  has_one_attached :image
end
