json.array! @courses do |course|
  json.name course.name
  json.units course.units
end