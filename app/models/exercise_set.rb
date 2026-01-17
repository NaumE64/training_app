class ExerciseSet < ApplicationRecord
  belongs_to :workout_exercise

  validates :set_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, numericality: { greater_than_or_equal_to: 0 }
  validates :reps, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Уникальность: не может быть двух подходов с одинаковым номером в одном упражнении
  validates :set_number, uniqueness: { scope: :workout_exercise_id }
end
