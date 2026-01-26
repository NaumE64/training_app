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
end