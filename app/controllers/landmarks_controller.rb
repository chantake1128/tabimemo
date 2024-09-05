class LandmarksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @landmark = Landmark.new
  end

  def create
    @landmark = Landmark.new(landmark_params)
    if @landmark.save
      redirect_to "/", notice: 'Landmark was successfully created.'      
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

def landmark_params
  params.require(:landmark).permit(:image, :name, :prefecture_id, :city, :street_address, :building_name)
end

end
