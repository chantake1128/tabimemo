class TravelForm
  include ActiveModel::Model
  attr_accessor :travel_name, :start_date, :end_date, :user_id, :date, :trip_id, :start_time, :end_time, :location, :description, :schedule_id

  with_options presence: true do
    validates :travel_name
    validates :start_date
    validates :end_date
    validates :date
    validates :start_time
    validates :end_time
    validates :location
  end

  def save
    return false unless valid?

      ActiveRecord::Base.transaction do
        trip = Trip.create!(
          travel_name:  travel_name,
          start_date:   start_date,
          end_date:     end_date
        )
        schedule = Schedule.create!(
          date: date, trip_id: trip_id
        )
        activities = Activities.create!(
          start_time:   start_time,
          end_time:     end_time,
          location:     location,
          description:  description
        )
      end
      true
      rescue ActiveRecord::RecordInvalid => e
        errors.add(:base, e.message)
      false

    end
  end