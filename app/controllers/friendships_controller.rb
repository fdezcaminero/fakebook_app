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
    if request.update(status: params[:status])
      requester =  User.find(current_user.id)
      requestee =  current_user.followers_friendships.find_by(requester_id: params[:requester_id]))
      Friendship.create(requester_id: requestee.id, requestee_id: requester.id, status: true)
      flash[:notice] = 'Friend confirmed'
      redirect_to users_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to users_path
    end
  end

  private

  def friendship_params
    params.permit(:requestee_id)
  end
end
