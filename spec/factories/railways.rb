FactoryBot.define do
  factory :railway do
    text {Faker::Lorem.sentence}
    association :user 
  end
end