class AddHeightAndActivityLevelToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :height, :integer
    add_column :users, :activity_level, :integer, default: 0
  end
end
