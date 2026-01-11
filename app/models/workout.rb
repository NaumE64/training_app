class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_type
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
  has_many :exercise_sets, through: :workout_exercises

  validates :date, presence: true
  validates :workout_type_id, presence: true
  validates :weight_before, numericality: { greater_than: 0 }, allow_nil: true
  validates :weight_after, numericality: { greater_than: 0 }, allow_nil: true
  validates :duration, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

  # Uniqueness: одна тренировка в день у пользователя
  validates :date, uniqueness: { scope: :user_id, message: "уже есть тренировка на эту дату" }
end
