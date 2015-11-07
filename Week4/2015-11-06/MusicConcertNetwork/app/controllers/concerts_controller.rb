class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all.order("date")
  end

  def show
    @concert = Concert.find_by(id: params[:id])
    @comments = @concert.comments
  end

  def new
    @concert = Concert.new
  end

  def create
    concert = Concert.new(safe_form_params)
    if concert.save
      flash[:alert] = "Concert created successfully."
      redirect_to concerts_path
    else
      flash[:error] = concert.errors.full_messages
      redirect_to new_concert_path
    end

  end

  def search
  end

  def search_by_price
    @concerts = Concert.search_by_price(safe_search_by_price_params.to_f)
    render "by_price"
  end

  def popular
    @concerts = Concert.search_by_popularity
  end

  private
  def safe_form_params
    params.require(:concert).permit(:band, :venue, :city, :date, :price, :description, :poster)
  end

  def safe_search_by_price_params
    params.permit(:price)[:price]
  end
end
