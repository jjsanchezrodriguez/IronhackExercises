class ProductsController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])
    @products = user.products
  end

  def index_all
    @products = Product.all
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @product = Product.new
  end

  def create
    date = combine_date(safe_product_params)
    @user = User.find_by(id: params[:user_id])
    @product = Product.new(user_id: @user.id, title: safe_product_params[:title], description: safe_product_params[:description], deadline: date,
                            minimum_bid: safe_product_params[:minimum_bid])

    if @product.save
      flash[:alert] = "Product created."
      redirect_to user_products_path(params[:user_id])
    else
      flash[:error] = @product.errors.full_messages
      redirect_to new_user_product_path(@user)
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @product = Product.find_by(id: params[:id])
    @bid = Bid.new
  end

  def destroy
  end

  def combine_date(safe_params)
    str = ""
    str += safe_params["deadline(1i)"] += "-"
    str += safe_params["deadline(2i)"] += "-"
    str += safe_params["deadline(3i)"] += " "
    str += safe_params["deadline(4i)"] += ":"
    str += safe_params["deadline(5i)"] += ":"
    str += ":00"
    str
  end

  private
  def safe_product_params
    params.require(:product).permit(:title, :description, :minimum_bid, "deadline(1i)", "deadline(2i)", "deadline(3i)", "deadline(4i)", "deadline(5i)")
  end
end
