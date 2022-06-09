FactoryBot.define do
  factory :price_scale do
    title             { Faker::Lorem.word }
    surface_treatment { Faker::Lorem.word }
    scale_w_0_3       { Faker::Number.within(range: 10..500) }
    scale_w_3_6       { Faker::Number.within(range: 10..500) }
    scale_w_6_11      { Faker::Number.within(range: 10..500) }
    scale_w_11_15     { Faker::Number.within(range: 10..500) }
    scale_w_15_22     { Faker::Number.within(range: 10..500) }
    scale_w_22_30     { Faker::Number.within(range: 10..500) }
    scale_w_30_50     { Faker::Number.within(range: 10..500) }
    scale_w_50_80     { Faker::Number.within(range: 10..500) }
    scale_w_80_150    { Faker::Number.within(range: 10..500) }
    scale_w_150_180   { Faker::Number.within(range: 10..500) }
    scale_w_180over   { Faker::Number.within(range: 10..500) }
    scale_a_0_3       { Faker::Number.within(range: 10..500) }
    scale_a_3_6       { Faker::Number.within(range: 10..500) }
    scale_a_6_11      { Faker::Number.within(range: 10..500) }
    scale_a_11_15     { Faker::Number.within(range: 10..500) }
    scale_a_15_22     { Faker::Number.within(range: 10..500) }
    scale_a_22_30     { Faker::Number.within(range: 10..500) }
    scale_a_30_50     { Faker::Number.within(range: 10..500) }
    scale_a_50_80     { Faker::Number.within(range: 10..500) }
    scale_a_80_150    { Faker::Number.within(range: 10..500) }
    scale_a_150_180   { Faker::Number.within(range: 10..500) }
    scale_a_180over   { Faker::Number.within(range: 10..500) }
    scale_o_0_300     { Faker::Number.within(range: 2..5) }
    scale_o_300_500   { Faker::Number.within(range: 2..5) }
    scale_o_500over   { Faker::Number.within(range: 2..5) }
    min_unit_price    { Faker::Number.within(range: 10..100) }
    min_total_price   { Faker::Number.within(range: 500..8000) }
  end
end
