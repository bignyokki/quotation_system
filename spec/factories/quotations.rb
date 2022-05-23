FactoryBot.define do
  factory :quotation do
    title { Faker::Lorem.word }
    total_price { Faker::Number.within(range: 1..100000) }
  end
end
