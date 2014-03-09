class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @current_media = @user.media.current_media if @user
    @recommendations = @user.recommendations if @user
    if current_user.id != params[:id]
      friendship = Friendship.find_by(user: current_user, friend: @user)
      @friendship = friendship if friendship && friendship.status = "accepted"
    end
  end
end