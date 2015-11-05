class BidsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    bid = Bid.new(amount: params[:bid][:amount], user_id: user.id, product_id: params[:product_id])
    bid.save
    redirect_to user_product_path(params[:user_id], params[:product_id])
  end

  private
  def safe_params
    params.require(:bid).permit(:amount)
  end
end
