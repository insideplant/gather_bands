FactoryBot.define do
  # Liveモデルのテストデータを定義
  factory :live do
    live_name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 10) }
    status { false }
    amount { [2..10] }
    start_at { '2022-01-19 00:00:00' }
    end_at { '2022-01-19 00:00:00' }
    association :live_house
  end
end