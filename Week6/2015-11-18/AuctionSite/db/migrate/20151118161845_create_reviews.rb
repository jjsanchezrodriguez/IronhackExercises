class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

      t.references :user, index: true
      t.references :product, index: true
      t.string :description
      t.timestamps null: false
    end
  end
end
