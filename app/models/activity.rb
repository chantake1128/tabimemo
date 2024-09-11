class Activity < ApplicationRecord
  belongs_to :schedule

  validates :start_time,  presence: true
  validates :end_time,    presence: true
  validates :location,    presence: true
  validates :description, presence: true
  validates :schedule_id, presence: true

end
