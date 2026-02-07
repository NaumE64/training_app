class AddWorkoutExercisesCountToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :workout_exercises_count, :integer, default: 0, null: false
  end
end
