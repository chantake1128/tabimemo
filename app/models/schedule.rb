class Schedule < ApplicationRecord
  belongs_to :trip
  has_many   :activities

  validates :date,    presence: true
  validates :trip_id, presence: true
end
