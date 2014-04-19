json.array! @courses do |course|
  json.id course.id
  json.name course.name
  json.units course.units
  json.drag true
end