json.array! @courses do |course|
  json.id course.id
  json.name course.name
  json.units course.units
  json.tagged_with course.rule_list
  json.drag true
end