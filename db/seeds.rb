WorkoutType.find_or_create_by!(name: "Грудь", description: "Тренировка грудных мышц")
WorkoutType.find_or_create_by!(name: "Спина", description: "Тренировка мышц спины")
WorkoutType.find_or_create_by!(name: "Ноги", description: "Тренировка ног и ягодиц")

chest = WorkoutType.find_by!(name: "Грудь")
back = WorkoutType.find_by!(name: "Спина")
legs = WorkoutType.find_by!(name: "Ноги")

# ГРУДЬ
Exercise.find_or_create_by!(name: "Жим лежа") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 8
  e.description = "Основное упражнение на грудные"
  e.order_position = 1
end

Exercise.find_or_create_by!(name: "Жим лежа на скамье") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 8
  e.order_position = 2
end

Exercise.find_or_create_by!(name: "Брусья") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 8
  e.order_position = 3
end

Exercise.find_or_create_by!(name: "Lateral raises") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Подъемы гантелей в стороны на плечи"
  e.order_position = 4
end

Exercise.find_or_create_by!(name: "Скамья плечи") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Жим гантелей сидя на плечи"
  e.order_position = 5
end

Exercise.find_or_create_by!(name: "Pullover") do |e|
  e.workout_type = chest
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Пуловер на грудные мышцы"
  e.order_position = 6
end

# СПИНА
Exercise.find_or_create_by!(name: "Pull down") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Тяга верхнего блока"
  e.order_position = 1
end

Exercise.find_or_create_by!(name: "Pulley") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Горизонтальная тяга"
  e.order_position = 2
end

Exercise.find_or_create_by!(name: "Upper back") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Упражнение на верх спины"
  e.order_position = 3
end

Exercise.find_or_create_by!(name: "Lat machine") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Тяга на широчайшие"
  e.order_position = 4
end

Exercise.find_or_create_by!(name: "Row") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Тяга штанги в наклоне"
  e.order_position = 5
end

Exercise.find_or_create_by!(name: "Low row") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Нижняя тяга"
  e.order_position = 6
end

Exercise.find_or_create_by!(name: "Бицепс штанга") do |e|
  e.workout_type = back
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Подъем штанги на бицепс"
  e.order_position = 7
end

# НОГИ
Exercise.find_or_create_by!(name: "Присед") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 6
  e.description = "Приседания со штангой"
  e.order_position = 1
end

Exercise.find_or_create_by!(name: "Рум. тяга") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 8
  e.description = "Румынская тяга"
  e.order_position = 2
end

Exercise.find_or_create_by!(name: "Leg extension") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Разгибание ног в тренажере"
  e.order_position = 3
end

Exercise.find_or_create_by!(name: "Leg curl") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Сгибание ног в тренажере"
  e.order_position = 4
end

Exercise.find_or_create_by!(name: "Abductor") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Разведение ног в тренажере"
  e.order_position = 5
end

Exercise.find_or_create_by!(name: "Adductor") do |e|
  e.workout_type = legs
  e.default_sets = 3
  e.default_reps = 15
  e.description = "Сведение ног в тренажере"
  e.order_position = 6
end

puts "Создано упражнений: #{Exercise.count}"
puts "Грудь: #{Exercise.where(workout_type: chest).count}"
puts "Спина: #{Exercise.where(workout_type: back).count}"
puts "Ноги: #{Exercise.where(workout_type: legs).count}"