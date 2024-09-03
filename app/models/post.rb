class Post < ApplicationRecord
  belongs_to :user
  belongs_to :landmark
  has_one_attached :image

  validates :title,       presence: true
  validates :body,        presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :status_id,   numericality: { other_than: 1, message: "can't be blank"}
  validates :score_id,    numericality: { other_than: 1, message: "can't be blank"}
end
