FactoryBot.define do
  factory :user do
    employee_number       {Faker::Number.number(digits: 4)}
    password              {Faker::Internet.password(min_length: 8, max_length: 16)}
    password_confirmation {password}
    name                  {Faker::Name.name}
    admin_id              {Faker::Number.within(range: 1..2)}
  end
end