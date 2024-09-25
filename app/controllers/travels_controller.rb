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
    # 編集するTripを取得
    @trip = Trip.find(params[:id])
    
    # フォームオブジェクトにデータを設定
    @travel_form = TravelForm.new(
      travel_name: @trip.travel_name,
      prefecture_id: @trip.prefecture_id,
      start_date: @trip.start_date,
      end_date: @trip.end_date,
      user_id: @trip.user_id,
      original_date: @trip.schedules.first&.date,
      original_start_time: @trip.schedules.first&.activities.first&.start_time,
      original_end_time: @trip.schedules.first&.activities.first&.end_time,
      original_location: @trip.schedules.first&.activities.first&.location,
      original_description: @trip.schedules.first&.activities.first&.description,
      additional_dates: @trip.schedules.pluck(:date),
      start_times: @trip.activities.pluck(:start_time),
      end_times: @trip.activities.pluck(:end_time),
      locations: @trip.activities.pluck(:location),
      descriptions: @trip.activities.pluck(:description)
    )
  end

  def update
    # Tripを取得
    @trip = Trip.find(params[:id])

    # フォームオブジェクトに編集されたデータをセット
    @travel_form = TravelForm.new(travel_form_params)
    @travel_form.trip = @trip # 既存のTripを設定

    # 更新処理の実行
    if @travel_form.update
      redirect_to trip_path(@trip), notice: '更新しました。'
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
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
