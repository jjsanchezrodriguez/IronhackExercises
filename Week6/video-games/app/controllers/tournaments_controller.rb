class TournamentsController < ApplicationController
  def index
    render "index"
  end

  def create
    tournament = Tournament.create(safe_params)
    render json: tournament, status: 201
  end

  def tournaments_all
    tournaments = Tournament.all
    render json: tournaments
  end

  def destroy
    tournament = Tournament.destroy(params[:id])
    render json: tournament
  end

  private
  def safe_params
    params.require(:tournament).permit(:name)
  end
end
