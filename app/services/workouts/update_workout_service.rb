class Workouts::UpdateWorkoutService
  def initialize(user:, params:, workout:)
    @user = user
    @params = params
    @workout = workout
  end

  def perform
    @workout.assign_attributes(workout_params)
    @workout.save ? @workout : @workout
  end

  private

  attr_reader :params, :workout

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