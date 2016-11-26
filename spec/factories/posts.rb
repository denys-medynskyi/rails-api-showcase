FactoryGirl.define do
  factory :post do
    title Faker::Name.title
    body Faker::Lorem.paragraph
  end
end
