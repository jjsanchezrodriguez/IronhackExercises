class RenameSynopsisToPlot < ActiveRecord::Migration
  def change
    remove_column :movies, :synopsis
    add_column :movies, :plot, :string
  end
end
