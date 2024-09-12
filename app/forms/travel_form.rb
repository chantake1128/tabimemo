class TravelForm
  include ActiveModel::Model

  attr_accessor :travel_name, :prefecture_id, :start_date, :end_date, :user_id,
                :original_date, :original_start_time, :original_end_time, :original_location, :original_description, :date,
                :additional_dates, :start_times, :end_times, :locations, :descriptions, :start_time, :end_time, :location, :description,
                :debug_info

  with_options presence: true do
    validates :travel_name
    validates :prefecture_id
    validates :start_date
    validates :end_date
    validates :user_id
    validates :original_date
    validates :original_start_time
    validates :original_end_time
    validates :original_location
    validates :original_description
  end

  def save
    return false unless valid?
    ActiveRecord::Base.transaction do
      @trip = Trip.create!(
        travel_name: travel_name,
        prefecture_id: prefecture_id,
        start_date: start_date,
        end_date: end_date,
        user_id: user_id
      )
      save_original_activity
      save_additional_schedules_and_activities
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  private

  def save_original_activity
    @schedule = Schedule.create!(
      date: original_date,
      trip_id: @trip.id
    )
    Activity.create!(
      start_time: original_start_time,
      end_time: original_end_time,
      location: original_location,
      description: original_description,
      trip_id: @trip.id,
      schedule_id: @schedule.id
    )
  end
  def save_additional_schedules_and_activities
    if additional_dates.present? && start_times.present?
      additional_date = additional_dates.values.first
      start_time = start_times.values.first
      end_time = end_times.values.first
      location = locations.values.first
      description = descriptions.values.first

      schedule = Schedule.create!(
        date: additional_date, 
        trip_id: @trip.id
      )

      activity = Activity.create!(
        start_time: start_time,
        end_time: end_time,
        location: location,
        description: description,
        trip_id: @trip.id,
        schedule_id: schedule.id
      )
    elsif additional_dates.present? && start_times.blank?
      additional_date = additional_dates.values.first

      schedule = Schedule.create!(
        date: additional_date, 
        trip_id: @trip.id
      )

    elsif start_times.present?
      latest_schedule_id = Schedule.where(trip_id: @trip.id).order(created_at: :desc).first.id
  
      start_time = start_times.values.first
      end_time = end_times.values.first
      location = locations.values.first
      description = descriptions.values.first
  
      activity = Activity.create!(
        start_time: start_time,
        end_time: end_time,
        location: location,
        description: description,
        trip_id: @trip.id,
        schedule_id: latest_schedule_id
      )
    end
  end
end


