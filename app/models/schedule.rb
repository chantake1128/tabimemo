class Schedule < ApplicationRecord
  belongs_to :trips
  has_many   :activities

  validates :date, presence: true
end
