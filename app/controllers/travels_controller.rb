class TravelsController < ApplicationController
  before_action :authenticate_user!

  def new
    @travel_form = TravelForm.new
  end

  def create
    form_params = params[:travel_form]
    if form_params[:start_date].present?
      begin
        form_params[:start_date] = Date.parse(form_params[:start_date])
      rescue ArgumentError, Date::Error => e
        flash[:error] = "無効な日付形式: #{form_params[:start_date]}"
        render :new and return
      end
    end

    if form_params[:end_date].present?
      begin
        form_params[:end_date] = Date.parse(form_params[:end_date])
      rescue ArgumentError, Date::Error => e
        flash[:error] = "無効な日付形式: #{form_params[:end_date]}"
        render :new and return
      end
    end

    if form_params[:original_date].present?
      begin
        form_params[:original_date] = Date.parse(form_params[:original_date])
      rescue ArgumentError, Date::Error => e
        flash[:error] = "無効な日付形式: #{form_params[:original_date]}"
        render :new and return
      end
    end

    if form_params[:original_start_time].present?
      begin
        form_params[:original_start_time] = Time.parse(form_params[:original_start_time])
      rescue ArgumentError => e
        flash[:error] = "無効な時間形式: #{form_params[:original_start_time]}"
        render :new and return
      end
    end

    if form_params[:original_end_time].present?
      begin
        form_params[:original_end_time] = Time.parse(form_params[:original_end_time])
      rescue ArgumentError => e
        flash[:error] = "無効な時間形式: #{form_params[:original_end_time]}"
        render :new and return
      end
    end

    @travel_form = TravelForm.new(travel_form_params.merge(user_id: current_user.id))

    if @travel_form.save
      redirect_to "/"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @trip = Trip.find(params[:id])
    @schedules = @trip.schedules.includes(:activities)
  end

  private

  def travel_form_params
    params.require(:travel_form).permit(
      :travel_name, :prefecture_id, :start_date, :end_date, :user_id,
      :original_date, :original_start_time, :original_end_time, :original_location, :original_description,
      :start_time, :end_time, :location, :description,:date,
      additional_dates: {}, start_times: {}, end_times: {}, locations: {}, descriptions: {}
    )
  end
end
