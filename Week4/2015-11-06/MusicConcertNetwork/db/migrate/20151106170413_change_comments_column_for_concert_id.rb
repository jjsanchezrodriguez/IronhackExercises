class ChangeCommentsColumnForConcertId < ActiveRecord::Migration
  def change
    drop_table :comments
    create_table :comments do |t|
      t.references :concert, index: true
      t.string :comment

      t.timestamps null: false
    end
  end
end
