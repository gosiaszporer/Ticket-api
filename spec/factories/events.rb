FactoryBot.define do
  factory :event do
    name { Faker::Music.band }
    date { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 30) }
  end
end