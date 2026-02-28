class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts
    .includes(:workout_type, :workout_exercises , workout_exercises: [:exercise, :exercise_sets])
    .order(date: :desc)
  end

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

  def show
    @workout = current_user.workouts
    .includes(workout_exercises: [:exercise, :exercise_sets])
    .find(params[:id])
  end

  def edit
    @workout = current_user.workouts
    .includes(workout_exercises: [:exercise, :exercise_sets])
    .find(params[:id])
    @exercises = @workout.exercises
  end

  def update
    workout = current_user.workouts.find(params[:id])
    service = Workouts::UpdateWorkoutService.new(
      user: current_user,
      params: params,
      workout: workout
    )

    @workout = service.perform

    if @workout.persisted? && @workout.errors.empty?
      redirect_to users_dashboard_path, notice: 'Обновлено!'
    else
      @exercises = @workout.exercises if @workout.workout_type_id
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    current_user.workouts.find(params[:id]).destroy!

    flash[:success] = 'Workout was successfully destroyed'
    redirect_to workouts_path
  end
end