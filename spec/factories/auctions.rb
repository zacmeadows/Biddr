FactoryGirl.define do
  factory :auction do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}"}
    details Faker::Lorem.paragraph
    price 10000000
    date "2019-11-11 10:33:20"
  end
end
