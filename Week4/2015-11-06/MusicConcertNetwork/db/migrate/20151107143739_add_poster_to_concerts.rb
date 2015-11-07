class AddPosterToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :poster, :string
  end
end
