class FoodEntry < ApplicationRecord
  belongs_to :user

  enum meal_type: %i[breakfast lunch dinner snack], presence: true

  validates :calories, numericality: { greater_than: 0 }, allow_nil: true
  validates :proteins, numericality: { greater_than: 0 }, allow_nil: true
  validates :fats, numericality: { greater_than: 0 }, allow_nil: true
  validates :carbs, numericality: { greater_than: 0 }, allow_nil: true
  validates :date, presence: true
  validate :date_not_in_future

  private

  def date_not_in_future
    return unless date.present? && date > Date.today

    errors.add(:date, 'cannot be in future')
  end
end
