class CreateExerciseSets < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :set_number, null: false
      t.decimal :weight, precision: 6, scale: 2, default: 0.0  # до 9999.99 кг
      t.integer :reps, default: 0
      t.boolean :completed, default: true
      t.text :notes
      t.timestamps
    end

    add_index :exercise_sets, [:workout_exercise_id, :set_number], unique: true
  end
end
