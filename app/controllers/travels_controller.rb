class TravelsController < ApplicationController
  before_action :authenticate_user!

  def new
    @travel_form = TravelForm.new
  end

  def create
    @travel_form = TravelForm.new(travel_form_params)

    if @travel_form.save
      redirect_to some_path, notice: 'Travel was successfully created.'
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

end
