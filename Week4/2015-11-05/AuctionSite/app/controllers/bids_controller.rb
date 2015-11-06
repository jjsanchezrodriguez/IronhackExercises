class BidsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    product = Product.find_by(id: params[:product_id])

    errors = Bid.validate_user_input(params, user, product)

    if errors.any?
      flash[:error] = errors
      redirect_to user_product_path(params[:user_id], params[:product_id])
    else
      bid = Bid.create(amount: params[:bid][:amount], user_id: user.id, product_id: params[:product_id])
      product.update(minimum_bid: bid.amount)
      flash[:alert] = "Bid successful."
      redirect_to user_product_path(params[:user_id], params[:product_id])
    end 


    #if user.nil?
      #flash[:error] = "User does not exist." 
      #redirect_to user_product_path(params[:user_id], params[:product_id])
    #elsif user.email == product.user.email
      #flash[:error] = "You cannot bid on your items."
      #redirect_to user_product_path(params[:user_id], params[:product_id])
    #else
      #bid = Bid.new(amount: params[:bid][:amount], user_id: user.id, product_id: params[:product_id])

      #if params[:bid][:amount].to_f < product.minimum_bid
        #flash[:error] = "Bid too low." 
        #redirect_to user_product_path(params[:user_id], params[:product_id])
      #elsif bid.save
        #flash[:alert] = "Bid successful."
        #redirect_to user_product_path(params[:user_id], params[:product_id])
      #else
        #flash[:error] = bid.errors.full_messages
        #redirect_to user_product_path(params[:user_id], params[:product_id])
      #end 
    #end
  end
end
