class FoodEntries::CreateFoodEntryService
  def initialize(food_entry_params:, user:)
    @food_entry_params = food_entry_params
    @user = user
  end

  attr_reader :food_entry_params, :user

  def perform
    food_entry = user.food_entries.build(food_entry_params)
    food_entry.save
    food_entry
  end
end
