class FoodEntriesController < ApplicationController
  def index
    @food_entries = current_user.food_entries
  end

  def new
    @food_entry = current_user.food_entries.new(
      date: Date.today,
      meal_type: params[:meal_type]
    )
  end

  def create
    service = FoodEntries::CreateFoodEntryService.new(
      food_entry_params: food_entry_params,
      user: current_user
    )

    @food_entry = service.perform

    if @food_entry.persisted?
      redirect_to users_dashboard_path, notice: "Сохранено!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def food_entry_params
    params.require(:food_entry).permit(:meal_type, :calories, :proteins, :fats, :carbs, :date, :notes)
  end
end
