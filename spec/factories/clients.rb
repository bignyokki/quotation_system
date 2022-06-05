FactoryBot.define do
  factory :client do
    transient do
      person { Gimei.name }
    end
    name         { "亜#{person.first.kanji}工業" }
    name_kana    { "あ#{person.first.hiragana}こうぎょう"} 
    phone_number { "012-345-6789" }
    fax_number   { "012-345-6780" }
    email        { Faker::Internet.free_email }
    postal_code  { "123-4567" }
  end
end
