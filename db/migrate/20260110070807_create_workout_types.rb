class CreateWorkoutTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_types do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    add_index :workout_types, :name, unique: true
  end
end
