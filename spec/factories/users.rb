FactoryBot.define do
  factory :user do
    employee_number       {Faker::Number.number(digits: 4)}
    password              {Faker::Lorem.characters(number: 8, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    name                  {Faker::Name.name}
    admin_id              {Faker::Number.within(range: 1..2)}
  end
end