class RecommendationsController < ApplicationController
  def new
    @user = User.find(params[:u_id])
    @recommendation = Recommendation.new
    respond_to do |format|
        format.html
        format.js { render 'recommendations/new' }
      end
  end

  def create
    @user = User.find(params[:user])
    @recommendation = @user.recommendations.build(recommendation_params_create)
    if @recommendation.save
      flash[:notice] = "Your recommendation has been created!"
      redirect_to @user
    else
      flash[:notice] = "There was a problem creating your recommendation."
      redirect_to @user
    end
  end

  def index
    @recommendations = current_user.recommendations
    @recommendations = @recommendations.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.destroy
      flash[:notice] = "Your recommendation was successfully deleted"
      redirect_to recommendations_path
    else
      flash[:notice] = "There was an error removing your recommendation"
      redirect_to recommendations_path
    end
  end

  private

  def recommendation_params_create
    params.require(:recommendation).permit(:creator_id, :body)
  end
end