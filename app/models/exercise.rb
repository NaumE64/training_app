class Exercise < ApplicationRecord
  belongs_to :workout_type
  has_many :workout_exercises, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :default_sets, numericality: { greater_than: 0 }
  validates :default_reps, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(:order_position, :name) }
end
