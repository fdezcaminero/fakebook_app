class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def create
    @following = current_user.friendships.build(friend_id: params[:user_id])
    if @following.save
      redirect_to root_path
    else
      flash[:alert] = "Couldn't be friend #{friendship_params[:user_id]}"
    end
  end

  def update
    @request = current_user.friendships.find_by(friend_id: params[:user_id])
    if @request.update(confirmed: true)
      redirect_to root_path
    else
      flash[:alert] = "Couldn't accept friend request"
    end
  end

  def destroy
    current_user.remove_friendship(params[:user_id])
    redirect_to root_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end
end
