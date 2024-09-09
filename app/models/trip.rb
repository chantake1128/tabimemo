class Trip < ApplicationRecord
  belongs_to :schedules
  
  validates :travel_name, presence: true
  validates :start_date,  presence: true
  validates :end_date,    presence: true
end
