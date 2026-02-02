class WorkoutsController < ApplicationController
  def new
    @workout = Workout.new(
      date: Date.today,
      workout_type_id: params[:workout_type_id]
    )
    @exercises = Exercise.where(workout_type_id: @workout.workout_type_id)
  end

  def create
    service = Workouts::CreateWorkoutService.new(
      params: params,
      user: current_user
    )

    @workout = service.perform

    if @workout.persisted?
      redirect_to users_dashboard_path, notice: "Сохранено!"
    else
      @exercises = Exercise.where(workout_type_id: @workout.workout_type_id) if @workout.workout_type_id
      render :new, status: :unprocessable_entity
    end
  end
end