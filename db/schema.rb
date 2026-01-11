# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2026_01_11_071155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "workout_type_id", null: false
    t.text "description"
    t.integer "default_sets", default: 3, null: false
    t.integer "default_reps", default: 8, null: false
    t.integer "order_position"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_exercises_on_active"
    t.index ["name"], name: "index_exercises_on_name", unique: true
    t.index ["workout_type_id", "order_position"], name: "index_exercises_on_workout_type_id_and_order_position"
    t.index ["workout_type_id"], name: "index_exercises_on_workout_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "age"
    t.decimal "current_weight"
    t.string "gender"
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "order", null: false
    t.text "notes"
    t.integer "target_sets"
    t.integer "target_reps"
    t.decimal "max_weight", precision: 5, scale: 2
    t.decimal "avg_weight", precision: 5, scale: 2
    t.integer "total_volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id", "exercise_id"], name: "index_workout_exercises_on_workout_id_and_exercise_id", unique: true
    t.index ["workout_id", "order"], name: "index_workout_exercises_on_workout_id_and_order", unique: true
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_workout_types_on_name", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "workout_type_id", null: false
    t.date "date", null: false
    t.decimal "weight_before", precision: 5, scale: 2
    t.decimal "weight_after", precision: 5, scale: 2
    t.text "notes"
    t.integer "duration"
    t.decimal "total_volume", precision: 10, scale: 2
    t.integer "total_sets"
    t.integer "total_reps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_workouts_on_date"
    t.index ["user_id", "date"], name: "index_workouts_on_user_id_and_date", unique: true
    t.index ["user_id", "workout_type_id"], name: "index_workouts_on_user_id_and_workout_type_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
    t.index ["workout_type_id"], name: "index_workouts_on_workout_type_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "exercises", "workout_types"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workouts", "users"
  add_foreign_key "workouts", "workout_types"
end
