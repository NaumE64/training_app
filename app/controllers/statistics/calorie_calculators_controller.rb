class Statistics::CalorieCalculatorsController < ApplicationController
  def show
    @user = current_user
  end

  def create
    service = Statistics::CalorieCalculatorService.new(
      user: current_user,
      params: calculator_params
    )

    service.perform

    flash[:success] = 'Calorie target per day calculated'
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    redirect_to users_dashboard_path
  end

  private

  def calculator_params
    params.permit(:height, :weight, :activity_level)
  end
end
