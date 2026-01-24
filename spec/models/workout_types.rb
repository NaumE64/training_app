require 'rails_helper'

RSpec.describe WorkoutType, type: :model do
  subject { build(:workout_type) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
  
  describe 'associations' do
    it { should have_many(:exercises) }
    it { should have_many(:workouts) }
  end
  
  describe 'database schema' do
    it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

    it { should have_db_index(:name).unique(true) }
  end
end