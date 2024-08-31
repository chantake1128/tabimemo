class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user, :landmark).all
    
  end

  
end
