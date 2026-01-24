FactoryBot.define do
  factory :workout do
    user
    workout_type
    date { Date.today }
  end
end