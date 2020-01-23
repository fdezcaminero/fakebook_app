class LikePostsController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.liked_posts.create(user: current_user)
    end
  end

  def destroy
    if !already_liked?
      flash[:notice] = "Can't unlike"
    else
      @liked_post.destroy
    end
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @liked_post = @post.liked_posts(params[:id])
  end

  def already_liked?
    LikedPost.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end
