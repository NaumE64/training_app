FactoryBot.define do
  factory :workout_exercise do
    association :workout
    association :exercise
    order { 1 }
  end
end
