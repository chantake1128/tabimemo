class TravelsController < ApplicationController
  before_action :authenticate_user!

  def new
    @travel_form = TravelForm.new
  end

  def create
    @travel_form = TravelForm.new(travel_form_params.merge(user_id: current_user.id))
  
    @travel_form.start_date = Date.parse(@travel_form.start_date) if @travel_form.start_date.is_a?(String)
    @travel_form.end_date = Date.parse(@travel_form.end_date) if @travel_form.end_date.is_a?(String)
    @travel_form.date = Date.parse(@travel_form.date) if @travel_form.date.is_a?(String)
  
    if @travel_form.save
      redirect_to "/", notice: 'Travel was successfully created.'
      #trip_path(@travel_form.trip_id)で詳細画面に移行するようにする
    else
      Rails.logger.error("TravelForm save failed: #{@travel_form.errors.full_messages.join(", ")}")
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def travel_form_params
    params.require(:travel_form).permit(:travel_name, :prefecture_id, :start_date, :end_date, :user_id, :date, :trip_id, :start_time, :end_time, :location, :description, :schedule_id)
  end
end
