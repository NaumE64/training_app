class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.references :workout_type, null: false, foreign_key: true
      t.text :description
      t.integer :default_sets, default: 3, null: false
      t.integer :default_reps, default: 8, null: false
      t.integer :order_position
      t.boolean :active, default: true
      t.timestamps
    end

    add_index :exercises, :name, unique: true
    add_index :exercises, [:workout_type_id, :order_position]
    add_index :exercises, :active
  end
end
