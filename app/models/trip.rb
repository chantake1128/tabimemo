class Trip < ApplicationRecord
  has_many :schedules
  belongs_to :user
  
  validates :travel_name, presence: true
  validates :start_date,  presence: true
  validates :end_date,    presence: true
end
