class WorkoutType < ApplicationRecord
  has_many :exercises
  has_many :workouts

  validates :name, presence: true, uniqueness: true
end
