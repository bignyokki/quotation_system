FactoryBot.define do
  factory :quotation do
    transient do
      person { Gimei.name }
    end
    title { Faker::Lorem.word }
    charge { person.first.kanji }
    delivery_date { "#{Faker::Number.within(range: 1..30)}日"}
    expiration_date { '1ヶ月' }
    delivery_place { '御社' }
    business_terms { '従来通り' }
    total_price { Faker::Number.within(range: 1..100000) }
    association :client
  end
end
