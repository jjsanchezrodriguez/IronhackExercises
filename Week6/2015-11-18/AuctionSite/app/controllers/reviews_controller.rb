class ReviewsController < ApplicationController
  def create
    Review.create(description: review_safe_params[:description], product_id: params[:product_id], user_id: current_user.id)
    redirect_to user_products_path
  end

  private

  def review_safe_params
    params.require(:review).permit(:description)
  end

end
