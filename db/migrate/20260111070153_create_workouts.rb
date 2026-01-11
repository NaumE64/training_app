class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workout_type, null: false, foreign_key: true
      t.date :date, null: false
      t.decimal :weight_before, precision: 5, scale: 2  # например: 84.50
      t.decimal :weight_after, precision: 5, scale: 2
      t.text :notes
      t.integer :duration
      t.decimal :total_volume, precision: 10, scale: 2  # сумма вес*повторения
      t.integer :total_sets
      t.integer :total_reps
      t.timestamps
    end

    add_index :workouts, :date
    add_index :workouts, [:user_id, :date], unique: true  # Одна тренировка в день
    add_index :workouts, [:user_id, :workout_type_id]
  end
end
