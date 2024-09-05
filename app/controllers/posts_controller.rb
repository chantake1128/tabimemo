class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit]
  before_action :set_post, only:[:show]
  def index
      landmark_ids = Landmark.where(prefecture_id: params[:prefecture_id]).pluck(:id)
      @posts = Post.includes(:landmark).where(landmark_id: landmark_ids)
      @prefecture = Prefecture.find(params[:prefecture_id])

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
      redirect_to @post, notice: 'Post was successfully created.'
    else
      @landmarks = Landmark.all
      render :new
    end
  end

  def show
  end
  
  private

  def set_post
    @post = Post.includes(:user, :landmark).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :title, :body,:status_id, :category_id, :score_id, :landmark_id, :user_id)
  end

end
