FactoryBot.define do
  factory :ticket do
    name { Faker::Music.key }
    price { Faker::Number.decimal(l_digits: 2) }
    quantity { Faker::Number.number(digits: 3) }
    event_id nil
  end
end