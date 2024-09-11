class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @trips = @user.trips.includes(schedules: :activities)
  end
end