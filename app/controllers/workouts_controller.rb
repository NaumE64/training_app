class WorkoutsController < ApplicationController
  def new
    @workout = Workout.new(
      date: Date.today,
      workout_type_id: params[:workout_type_id]
    )
    @exercises = Exercise.where(workout_type_id: @workout.workout_type_id)
  end

  def create
  end

  private

  def workout_params
    params.require(:workout).permit(
      :workout_type_id,
      :date,
      :weight_before,
      :weight_after,
      :duration,
      :notes,
      workout_exercises_attributes: [
        :id,
        :exercise_id,
        :order,
        :target_sets,
        :target_reps,
        :notes,
        :_destroy,
        exercise_sets_attributes: [
          :id,
          :set_number,
          :weight,
          :reps,
          :completed,
          :notes,
          :_destroy
        ]
      ]
    )
  end
end