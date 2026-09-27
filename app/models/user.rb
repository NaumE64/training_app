class User < ApplicationRecord
  has_one_attached :avatar
  has_many :workouts
  has_many :workout_exercises, through: :workouts
  has_many :food_entries

  enum activity_level: %i[sedentary light medium high very_high]

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :target_weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :daily_calorie_goal, numericality: { greater_than: 0 }, allow_nil: true
  validates :daily_calorie_target, numericality: { greater_than: 0 }, allow_nil: true

  def public_name
    [first_name, last_name].join(' ')
  end

  ACTIVITY_MULTIPLIERS = {
    'sedentary' => 1.2,
    'light' => 1.375,
    'medium' => 1.55,
    'high' => 1.725,
    'very_high' => 1.9
  }.freeze
end
