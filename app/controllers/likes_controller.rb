class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = current_user.likes.build(post: @post)

    if @like.save
      respond_with_success('Liked the post.')
    else
      respond_with_failure('Error in liking the post.')
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)

    if like && like.destroy
      respond_with_success('Removed the like.')
    else
      respond_with_failure('Failed to remove the like.' || 'Like not found.')
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def respond_with_success(message)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("like-btn#{@post.id}", partial: 'likes/like', locals: { post: @post }) }
      format.html { redirect_to @post, notice: message }
    end
  end

  def respond_with_failure(message)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("like-btn#{@post.id}", partial: 'likes/errors', locals: { message: message }) }
      format.html { redirect_to @post, alert: message }
    end
  end
end
