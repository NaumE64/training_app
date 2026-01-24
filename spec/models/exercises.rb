require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:default_sets).is_greater_than(0) }
    it { should validate_numericality_of(:default_reps).is_greater_than(0) }
  end
  
  describe 'associations' do
    it { should belong_to(:workout_type) }
    it { should have_many(:workout_exercises).dependent(:restrict_with_error) }
  end
  
  describe 'database schema' do
    it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    it { should have_db_column(:workout_type_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:default_sets).of_type(:integer).with_options(default: 3, null: false) }
    it { should have_db_column(:default_reps).of_type(:integer).with_options(default: 8, null: false) }
    it { should have_db_column(:order_position).of_type(:integer) }
    it { should have_db_column(:active).of_type(:boolean).with_options(default: true) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    
    it { should have_db_index(:active) }
    it { should have_db_index(:name).unique(true) }
    it { should have_db_index([:workout_type_id, :order_position]) }
    it { should have_db_index(:workout_type_id) }
  end
  
end