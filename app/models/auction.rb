class Auction < ActiveRecord::Base

  validates :title, :details, :price, :date, presence: true

  has_many :bids, dependent: :destroy 

end
