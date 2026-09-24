class ChangeMealTypeToIntegerInFoodEntries < ActiveRecord::Migration[7.0]
  def change
    change_column :food_entries, :meal_type, :integer, using: 'meal_type::integer'
  end
end
