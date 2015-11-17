class Player < ActiveRecord::Base
  has_many :matches_won, :class_name => 'Match', :foreign_key => 'winner_id'
  has_many :matches_lost, :class_name => 'Match', :foreign_key => 'loser_id'

  def self.player_profile(id)
    p = Player.find_by(id: id)
    percentage = (p.matches_won.length + p.matches_lost.length).to_f / p.matches_won.length == 0 ? nil : p.matches_won.length
   percentage_won = percentage == nil ? 0 : percentage_won = percentage

    return { player: p,
      matches_won: p.matches_won,
      matches_lost: p.matches_lost,
      percentage_won: percentage_won
    }
  end

  def self.by_faction(id)
    p = Player.find_by(id: id)
    matches = p.matches_won + p.matches_lost
    result = {player: p, matches: {}}
    ["Terran", "Protos", "Zerg"].each do |faction|
      result[:matches][faction] = {}
      result[:matches][faction]['won'] = p.matches_won.all.where(winner_faction: faction, winner_id: p.id)
      result[:matches][faction]['lost'] = p.matches_lost.all.where(loser_faction: faction, loser_id: p.id)
    end
    result
  end
end
