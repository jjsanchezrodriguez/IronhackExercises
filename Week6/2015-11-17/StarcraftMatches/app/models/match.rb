class Match < ActiveRecord::Base
  belongs_to :winner, :class_name => 'Player'
  belongs_to :loser, :class_name => 'Player'

  def self.faction_matches_won(faction)
    Match.all.where(winner_faction: faction.capitalize)
  end

  def self.faction_matches_lost(faction)
    Match.all.where(loser_faction: faction.capitalize)
  end

  def self.faction_matches(faction)
    won = self.faction_matches_won(faction)
    lost = self.faction_matches_lost(faction)
    #percentage = (won.length + lost.length).to_f / won.length
    percentage =  won.length == 0.00 ? nil : won.length.to_f / (won.length + lost.length).to_f

    return { win_percentage: (percentage * 100) , matches: won + lost }
  end

end
