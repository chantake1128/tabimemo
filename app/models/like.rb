class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  validates :user_id, uniqueness: { scope: :post_id, message: "You have already liked this post." }
end
