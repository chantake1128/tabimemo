class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update, :destroy]

  def index
    landmark_ids = Landmark.where(prefecture_id: params[:prefecture_id]).pluck(:id)
    @posts = Post.includes(:landmark).where(landmark_id: landmark_ids).limit(5)
    @prefecture = Prefecture.find(params[:prefecture_id])
    #旅のしおり機能のため
    @trips = Trip.where(prefecture_id: params[:prefecture_id]).limit(10)
    #/旅のしおり機能のため
    if landmark_ids.any?
      @landmark = Landmark.find(landmark_ids.first)
    else
      @landmark = nil
    end
  end

  def new
    @post = Post.new
    @landmarks = Landmark.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to "/", notice: 'Post was successfully created.'
    else
      @landmarks = Landmark.all
      render :new
    end
  end

  def show
  end

  def edit
    @landmarks = Landmark.all
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.includes(:user, :landmark).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :title, :body,:status_id, :category_id, :score_id, :landmark_id, :user_id)
  end

  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to root_path
    end
  end

end
