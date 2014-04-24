json.array! @courses do |course|
  json.id course.id
  json.name course.name
  json.dept course.dept
  json.number course.number
  json.units course.units
  json.description course.description
  json.tagged_with course.rule_list
  json.drag true
end