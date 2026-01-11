class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :exercise_sets, dependent: :destroy

  validates :workout_id, presence: true
  validates :exercise_id, presence: true
  validates :order, presence: true, numericality: { greater_than: 0 }
  validates :target_sets, numericality: { greater_than: 0 }, allow_nil: true
  validates :target_reps, numericality: { greater_than: 0 }, allow_nil: true
  
  # Уникальность: одно упражнение один раз в тренировке
  validates :exercise_id, uniqueness: { scope: :workout_id }
end
