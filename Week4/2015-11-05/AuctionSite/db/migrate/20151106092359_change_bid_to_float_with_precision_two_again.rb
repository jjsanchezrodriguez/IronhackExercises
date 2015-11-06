class ChangeBidToFloatWithPrecisionTwoAgain < ActiveRecord::Migration
  def change
    remove_column :bids, :amount
    add_column :bids, :amount, :decimal, :precision => 3, :scale => 2
  end
end
