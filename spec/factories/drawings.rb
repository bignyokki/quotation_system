FactoryBot.define do
  factory :drawing do
    figure_number     { Faker::Lorem.characters(number: 10) }
    surface_treatment { Faker::Lorem.word }
    quantity          { Faker::Number.within(range: 1..1000) }
    price             { Faker::Number.within(range: 1..100000) }
    quotation_id      { Faker::Number.within(range: 1..10) }
  end
end
