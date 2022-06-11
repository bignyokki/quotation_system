FactoryBot.define do
  factory :drawing do
    figure_number     { Faker::Lorem.characters(number: 10) }
    product_name      { Faker::Lorem.word }
    material          { Faker::Lorem.word }
    surface_treatment { Faker::Lorem.word }
    quantity          { Faker::Number.within(range: 1..1000) }
    price             { Faker::Number.within(range: 1..100000) }
    association :quotation
  end
end
