FactoryBot.define do
  factory :workout do
    user
    workout_type
    date { Date.today }
    weight_before { 86.1 }
    weight_after { 85.8 }
    workout_exercises_count { 15 }
  end
end