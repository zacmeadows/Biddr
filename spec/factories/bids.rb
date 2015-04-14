FactoryGirl.define do 

  factory :bid do
    association :auction, factory: :auction
    bid_price 100 
  end
end
