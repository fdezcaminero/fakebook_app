class FriendshipsController < ApplicationController
  def create
    following = current_user.following_friendships.new(friendship_params)
    flash[:alert] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless following.save
    redirect_to users_path
  end

  def destroy
    current_user.remove_friendship params[:requestee_id]
    redirect_to users_path
  end

  def update
    request = current_user.followers_friendships.find_by(requester_id: params[:requester_id])
    flash[:alert] = "Couldn't accept request." unless request.update(status: params[:status])
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
