class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def create
    following = current_user.friendships.build(friendship_params)
    if following.save
      redirect_to root_path
    else
      flash[:alert] = "Couldn't be friend #{friendship_params[:user_id]}"
    end
  end

  def destroy
    current_user.remove_friendship(params[:user_id])
    redirect_to root_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
