class ChangeBidToFloatWithPrecisionTwo < ActiveRecord::Migration
  def change
    remove_column :bids, :amount
    add_column :bids, :amount, :decimal, :precision => 2, :scale => 2
  end
end
