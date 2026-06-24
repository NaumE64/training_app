class User < ApplicationRecord
  has_one_attached :avatar
  has_many :workouts
  has_many :workout_exercises, through: :workouts
  has_many :food_entries

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
end
