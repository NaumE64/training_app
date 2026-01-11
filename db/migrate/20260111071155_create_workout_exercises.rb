class CreateWorkoutExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_exercises do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :order, null: false  # Порядок выполнения (1, 2, 3...)
      t.text :notes                   # Особые заметки по этому упражнению
      t.integer :target_sets          # Планируемое кол-во подходов
      t.integer :target_reps          # Планируемое кол-во повторений
      
      # Для статистики (можно вычислять, но храним для скорости)
      t.decimal :max_weight, precision: 5, scale: 2
      t.decimal :avg_weight, precision: 5, scale: 2
      t.integer :total_volume 
      t.timestamps
    end

    add_index :workout_exercises, [:workout_id, :exercise_id], unique: true
    add_index :workout_exercises, [:workout_id, :order], unique: true
  end
end
