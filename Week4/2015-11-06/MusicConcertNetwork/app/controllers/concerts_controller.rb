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
      flash[:error] = concert.errors.messages
      redirect_to new_concert_path
    end

  end

  private
  def safe_form_params
    params.require(:concert).permit(:band, :venue, :city, :date, :price, :description)
  end
end
