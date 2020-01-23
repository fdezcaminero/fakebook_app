class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    # @comment = @post.comments.create(comment_params)
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @comment.post
    else
      flash.now[:danger] = 'error'
      redirect_back(fallback_location: root_path)
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
