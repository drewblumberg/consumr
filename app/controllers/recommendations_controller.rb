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

  private

  def recommendation_params_create
    params.require(:recommendation).permit(:creator_id, :body)
  end
end