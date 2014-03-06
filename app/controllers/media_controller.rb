class MediaController < ApplicationController
  def index
    @medium = Medium.all
    @current_media = current_user.media.current_media if current_user
  end

  def new
    @medium = Medium.new
  end

  def create
    @medium = current_user.media.build(medium_params_create)
    if @medium.save
      flash[:notice] = "Your media has been created!"
      redirect_to new_medium_path
    else
      flash[:notice] = "There was a problem creating your media."
      redirect_to new_medium_path
    end
  end

  private

  def medium_params_create
    params.require(:medium).permit(:title, :status, :image_url, :creator, :category, :thoughts)
  end
end