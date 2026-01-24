require 'rails_helper'

RSpec.describe ExerciseSet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:set_number) }
    it { should validate_numericality_of(:set_number).only_integer.is_greater_than(0) }
    it { should validate_numericality_of(:weight).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:reps).only_integer.is_greater_than_or_equal_to(0) }
    # it { should validate_uniqueness_of(:set_number).scoped_to(:workout_exercise_id) }
  end
  
  describe 'associations' do
    it { should belong_to(:workout_exercise) }
  end
  
  describe 'database schema' do
    it { should have_db_column(:workout_exercise_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:set_number).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:weight).of_type(:decimal).with_options(precision: 6, scale: 2, default: 0.0) }
    it { should have_db_column(:reps).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:completed).of_type(:boolean).with_options(default: true) }
    it { should have_db_column(:notes).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

    it { should have_db_index([:workout_exercise_id, :set_number]).unique(true) }
    it { should have_db_index(:workout_exercise_id) }
  end
end
