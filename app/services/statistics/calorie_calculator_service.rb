class Statistics::CalorieCalculatorService
  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def perform
    update_user_params
    tdee = calculate_tdee
    target = (tdee - 400).round

    user.update!(
      daily_calorie_goal: tdee.round,
      daily_calorie_target: target
    )
  end

  private

  attr_reader :params, :user

  def update_user_params
    user.update!(
      current_weight: params[:weight].to_f,
      height: params[:height].to_i,
      activity_level: params[:activity_level]
    )
  end

  def gender_offset
    user.gender == 'female' ? -161 : 5
  end

  def activity_multiplier
    User::ACTIVITY_MULTIPLIERS[user.activity_level] || 1.55
  end

  def calculate_bmr
    10 * user.current_weight + 6.25 * user.height - 5 * user.age + gender_offset
  end

  def calculate_tdee
    calculate_bmr * activity_multiplier
  end
end
