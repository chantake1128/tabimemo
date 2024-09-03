class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only:[:show]
  def index
    @posts = Post.includes(:user, :landmark).all
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
