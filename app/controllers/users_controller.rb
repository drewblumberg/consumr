class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @current_media = @user.media.current_media if @user
    @recommendations = @user.recommendations if @user
    if current_user != @user
      friendship = Friendship.find_by(user: current_user, friend: @user)
      @friendship = friendship if friendship && friendship.status = "accepted"
    end
  end
end