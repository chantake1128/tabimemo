class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user, :landmark).all
  end

  def new
  end

  def create
  end

  def show
  end
  
end
