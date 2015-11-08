class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :movies
      t.string :comment

      t.timestamps null: false
    end
  end
end
