class AddUserIdAndTournamentIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :user_id, :integer
    add_column :registrations, :tournament_id, :integer
  end
end
