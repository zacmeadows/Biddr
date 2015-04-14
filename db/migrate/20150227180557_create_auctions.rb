class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.float :price
      t.datetime :date

      t.timestamps null: false
    end
  end
end
