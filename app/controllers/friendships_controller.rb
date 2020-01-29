class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[update destroy]

  def create
    following = current_user.following_friendships.new(friendship_params)
    flash[:alert] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless following.save
    redirect_to users_path
  end

  def destroy
    requestee = User.find(params[:requestee_id])
    current_user.remove_friendship(requestee.id)
    requestee.remove_friendship(current_user.id)
    redirect_to users_path
  end

  def update
    requester = User.find(params[:requester_id])
    request = current_user.followers_friendships.find_by(requester: requester)
    if request.update(status: params[:status])
      Friendship.create(requester: current_user, requestee: requester, status: params[:status])
      flash[:notice] = 'Friend confirmed'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:requestee_id, :status)
  end

  def correct_user
    user = User.find_by(id: params[:requester_id])
    redirect_to(user) unless current_user
  end
end
