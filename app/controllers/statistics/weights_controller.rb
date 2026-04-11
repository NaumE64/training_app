class Statistics::WeightsController < ApplicationController
  def show
    @weight_data = current_user.workouts
      .where.not(weight_before: nil)
      .order(date: :asc)
      .pluck(:date, :weight_before)
  end
end