class Workouts::CreateWorkoutService
  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def perform
    create_workout_with_nested
  end

  private

  attr_reader :params, :user

  def create_workout_with_nested
    workout = user.workouts.build(workout_params)

    if workout.save!
      workout
    else
      workout
    end
  end

  def workout_params
    permitted = params.require(:workout).permit(
      :workout_type_id,
      :date,
      :weight_before,
      :weight_after,
      :duration,
      :notes,
      workout_exercises_attributes: [
        :exercise_id,
        :order,
        :target_sets,
        :target_reps,
        :notes,
        exercise_sets_attributes: [
          :set_number,
          :weight,
          :reps,
          :completed,
          :notes
        ]
      ]
    )

    permitted
  end
end