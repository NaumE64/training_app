class CreateFoodEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :food_entries do |t|
      t.string :meal_type, null: false
      t.integer :calories, null: false
      t.integer :proteins, null: false
      t.integer :fats, null: false
      t.integer :carbs, null: false
      t.string :notes
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :food_entries, %i[user_id date]
    add_index :food_entries, %i[user_id meal_type]
  end
end
