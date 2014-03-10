class MediaController < ApplicationController
  def index
    @all_media = Medium.paginate(:page => params[:page], :per_page => 20)
    @current_media = current_user.media.current_media
    @finished_media = current_user.media.finished
    @wish_list = current_user.media.wish_list
  end

  def new
    @medium = Medium.new
  end

  def edit
    @medium = Medium.find(params[:id])
  end

  def update
    @medium = Medium.find(params[:id])
    if @medium.update(medium_params_create)
      flash[:notice] = "Media was successfully updated!"
      redirect_to media_path
    else
      flash[:notice] = "There was a problem updating your media."
      redirect_to media_path
    end
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

  def destroy
    @medium = Medium.find(params[:id])
    if @medium.destroy
      flash[:notice] = "Your media was successfully removed"
      redirect_to media_path
    else
      flash[:notice] = "There was an error removing your media"
      redirect_to media_path
    end
  end

  private

  def medium_params_create
    params.require(:medium).permit(:title, :status, :image_url, :creator, :category, :thoughts)
  end
end