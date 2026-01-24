FactoryBot.define do
  factory :exercise do
    workout_type
    sequence(:name) { |n| "Exercise #{n}" }
    default_sets { 3 }
    default_reps { 8 }
    order_position { 1 }
    active { true }
    
    trait :inactive do
      active { false }
    end
    
    trait :with_description do
      description { 'Test exercise description' }
    end
  end
end