class ChangeRegistrationsPlayerColumn < ActiveRecord::Migration
  def change
    remove_column :registrations, :user_id
    add_column :registrations, :player_id, :integer

  end
end
