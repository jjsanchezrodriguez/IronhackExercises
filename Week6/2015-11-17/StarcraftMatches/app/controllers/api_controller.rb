class ApiController < ActionController::Base
  def faction_matches
    results = Match.faction_matches(params[:faction])
    render json: results
  end

  def player_profile
    profile = Player.player_profile(params[:id])
    render json: profile
  end

  def player_matches_by_faction
    matches = Player.by_faction(params[:id])
    render json: matches
  end
end
