class AddTargetWeightFieldToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :target_weight, :decimal, precision: 5, scale: 2
    add_column :users, :daily_calorie_goal, :integer
    add_column :users, :daily_calorie_target, :integer
  end
end
