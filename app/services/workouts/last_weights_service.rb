class Workouts::LastWeightsService
  def initialize(workout_type_id:, user:)
    @workout_type_id = workout_type_id
    @user = user
  end

  def perform
    exercise_ids = fetch_exercise_ids
    last_sets = fetch_last_exercise_sets(exercise_ids)
    build_weights_hash(last_sets)
  end

  private

  attr_reader :user, :workout_type_id

  def fetch_exercise_ids
    WorkoutType.find(workout_type_id).exercise_ids
  end

  def fetch_last_exercise_sets(exercise_ids)
    ExerciseSet
      .joins(workout_exercise: :workout)
      .where(workouts: { user_id: user.id })
      .where(workout_exercises: { exercise_id: exercise_ids })
      .order("workout_exercises.exercise_id, workouts.date DESC")
      .select("DISTINCT ON (workout_exercises.exercise_id) workout_exercises.exercise_id, exercise_sets.weight")
  end

  def build_weights_hash(sets)
    sets.each_with_object({}) do |set, hash|
      hash[set.exercise_id] = set.weight
    end
  end
end
