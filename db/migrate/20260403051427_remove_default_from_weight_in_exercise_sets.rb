class RemoveDefaultFromWeightInExerciseSets < ActiveRecord::Migration[7.0]
  def change
    change_column_default :exercise_sets, :weight, from: 0.0, to: nil
  end
end
