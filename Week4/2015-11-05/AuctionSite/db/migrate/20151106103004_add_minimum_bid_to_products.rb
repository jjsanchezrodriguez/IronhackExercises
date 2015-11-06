class AddMinimumBidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :minimum_bid, :decimal, :precision => 3, :scale => 2
  end
end
