class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout, inverse_of: :workout_exercises
  has_many :exercise_sets, inverse_of: :workout_exercise, dependent: :destroy

  validates :workout_id, presence: true, unless: -> { workout.present? }
  validates :exercise_id, presence: true
  validates :order, presence: true, numericality: { greater_than: 0 }
  validates :target_sets, numericality: { greater_than: 0 }, allow_nil: true
  validates :target_reps, numericality: { greater_than: 0 }, allow_nil: true

  validates :exercise_id, uniqueness: { scope: :workout_id }, if: -> { workout_id.present? }

  accepts_nested_attributes_for :exercise_sets,
    allow_destroy: true,
    reject_if: ->(attrs) { attrs['weight'].blank? && attrs['reps'].blank? }

  validates_associated :exercise_sets

  delegate :name, to: :exercise, prefix: true, allow_nil: true
end
