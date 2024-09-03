class PostsController < ApplicationController
  before_action :set_post, only:[:show]
  def index
    @posts = Post.includes(:user, :landmark).all
  end

  def new
  end

  def create
  end

  def show
  end
  
  private

  def set_post
    @post = Post.includes(:user, :landmark).find(params[:id])
  end

end
