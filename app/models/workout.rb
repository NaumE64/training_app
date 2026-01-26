class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_type
  has_many :workout_exercises, inverse_of: :workout, dependent: :destroy
  has_many :exercises, through: :workout_exercises
  has_many :exercise_sets, through: :workout_exercises

  validates :date, presence: true
  validates :workout_type_id, presence: true
  validates :weight_before, numericality: { greater_than: 0 }, allow_nil: true
  validates :weight_after, numericality: { greater_than: 0 }, allow_nil: true
  validates :duration, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

  validates :date, uniqueness: { scope: :user_id, message: "уже есть тренировка на эту дату" }

  accepts_nested_attributes_for :workout_exercises,
    allow_destroy: true,
    reject_if: ->(attrs) { attrs['exercise_id'].blank? }

  validates_associated :workout_exercises
end
