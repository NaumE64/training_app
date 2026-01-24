require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do
  subject { FactoryBot.build(:workout_exercise) }

  describe 'validations' do
    it { should validate_presence_of(:workout_id) }
    it { should validate_presence_of(:exercise_id) }
    it { should validate_presence_of(:order) }
    it { should validate_numericality_of(:order).is_greater_than(0) }
    it { should validate_numericality_of(:target_sets).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:target_reps).is_greater_than(0).allow_nil }
    
    # it { should validate_uniqueness_of(:exercise_id).scoped_to(:workout_id) }
  end
  
  describe 'associations' do
    it { should belong_to(:workout) }
    it { should belong_to(:exercise) }
    it { should have_many(:exercise_sets).dependent(:destroy) }
  end
  
  describe 'database schema' do
    it { should have_db_column(:workout_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:exercise_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:order).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:notes).of_type(:text) }
    it { should have_db_column(:target_sets).of_type(:integer) }
    it { should have_db_column(:target_reps).of_type(:integer) }
    it { should have_db_column(:max_weight).of_type(:decimal).with_options(precision: 5, scale: 2) }
    it { should have_db_column(:avg_weight).of_type(:decimal).with_options(precision: 5, scale: 2) }
    it { should have_db_column(:total_volume).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    
    it { should have_db_index(:exercise_id) }
    it { should have_db_index([:workout_id, :exercise_id]).unique(true) }
    it { should have_db_index([:workout_id, :order]).unique(true) }
    it { should have_db_index(:workout_id) }
  end
end