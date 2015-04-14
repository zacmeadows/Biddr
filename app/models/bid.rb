class Bid < ActiveRecord::Base

  validates :bid_price, presence: true
  validates :bid_price, numericality: {greater_than: 1}

  belongs_to :auction

end
