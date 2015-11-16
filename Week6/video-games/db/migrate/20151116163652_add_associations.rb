class AddAssociations < ActiveRecord::Migration
  def change
    drop_table :players
    drop_table :tournaments
    drop_table :registrations

    create_table :tournaments do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :registrations do |t|
      t.belongs_to :tournament, index: true
      t.belongs_to :player, index: true
      t.integer :player_id
      t.integer :tournament_id

      t.timestamps null: false
    end

    create_table :players do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
