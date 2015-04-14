class AddCurrentBidToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :current_bid, :integer
  end
end
