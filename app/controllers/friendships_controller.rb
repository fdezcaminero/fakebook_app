class FriendshipsController < ApplicationController
  def create
    following = current_user.following_friendships.new(friendship_params)
    flash[:alert] = "Couldn't befriend #{friendship_params[:requestee_id]}" unless following.save
    redirect_to users_path
  end

  def destroy
    requester = current_user
    requestee = User.find(params[:requestee_id])
    current_user.remove_friendship(requestee.id)
    requestee.remove_friendship(requester.id)
    redirect_to users_path
  end

  def update
    requester = User.find(params[:requester_id])
    requestee = current_user
    request = current_user.followers_friendships.find_by(requester: requester)
    if request.update(status: params[:status])
      Friendship.create(requester: requestee, requestee: requester, status: 1)
      flash[:notice] = 'Friend confirmed'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
