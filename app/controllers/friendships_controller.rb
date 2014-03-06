class FriendshipsController < ApplicationController
  def friend_request
    @user = current_user
    @friend = User.find(params[:friend_id])
    unless @friend.nil?
      if Friendship.request(@user, @friend)
        flash[:notice] = "Friendship requested with #{@friend.full_name}."
      else
        flash[:notice] = "Friendship unable to be requested with #{@friend.full_name}."
      end
    end
    redirect_to @friend
  end

  def my_friends
    @pending = current_user.friendships.pending_friends
    @requests = current_user.friendships.requested_friends
    render "/friendships/my_friends"
  end

  def accept
    @user = current_user
    @friend = User.find_by(id: params[:f_id])
    unless @friend.nil?
      if Friendship.accept(@user, @friend)
        flash[:notice] = "Friendship accepted with #{@friend.full_name}."
      else
        flash[:notice] = "Friendship unable to be accepted with #{@friend.full_name}."
      end
    end
    redirect_to my_friends_friendships_path
  end

  def reject
    @user = current_user
    @friend = User.find_by(id: params[:f_id])
    unless @friend.nil?
      if Friendship.reject(@user, @friend)
        flash[:notice] = "Friendship rejected with #{@friend.full_name}."
      else
        flash[:notice] = "Friendship unable to be rejected with #{@friend.full_name}."
      end
    end
    redirect_to my_friends_friendships_path
  end
end