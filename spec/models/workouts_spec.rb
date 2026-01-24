require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'validations' do
    # Presence validations
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:workout_type_id) }
    
    # Numericality validations
    it { should validate_numericality_of(:weight_before).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:weight_after).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:duration).only_integer.is_greater_than(0).allow_nil }
    
    # Uniqueness validation
    # it { should validate_uniqueness_of(:date).scoped_to(:user_id) }
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:workout_type) }
    it { should have_many(:workout_exercises).dependent(:destroy) }
    it { should have_many(:exercises).through(:workout_exercises) }
    it { should have_many(:exercise_sets).through(:workout_exercises) }
  end
  
  describe 'database schema' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:workout_type_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:date).of_type(:date).with_options(null: false) }
    it { should have_db_column(:weight_before).of_type(:decimal).with_options(precision: 5, scale: 2) }
    it { should have_db_column(:weight_after).of_type(:decimal).with_options(precision: 5, scale: 2) }
    it { should have_db_column(:notes).of_type(:text) }
    it { should have_db_column(:duration).of_type(:integer) }
    it { should have_db_column(:total_volume).of_type(:decimal).with_options(precision: 10, scale: 2) }
    it { should have_db_column(:total_sets).of_type(:integer) }
    it { should have_db_column(:total_reps).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    
    it { should have_db_index(:date) }
    it { should have_db_index([:user_id, :date]).unique(true) }
    it { should have_db_index([:user_id, :workout_type_id]) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(:workout_type_id) }
  end
end