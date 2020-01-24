class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def create
    following = current_user.friendships.new(friendship_params)
    if following.save
      redirect_to root_path
    else
      flash[:alert] = "Couldn't be friend #{friendship_params[:friend_id]}"
    end
  end

  def destroy
    current_user.remove_friendship params[:friend_id]
    redirect_to root_path
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end
end
