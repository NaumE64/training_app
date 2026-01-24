FactoryBot.define do
  factory :workout_type do
    sequence(:name) { |n| "Workout Type #{n}" }
    description { "Test description" }
  end
end