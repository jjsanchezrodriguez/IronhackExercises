class PlayersController < ApplicationController

  def index_all
    players = Player.all
    render json: players
  end

  def tournament_players
    tournament = Tournament.find_by(id: params[:tournament][:id])
    players = tournament.players

    render json: players
  end
end
