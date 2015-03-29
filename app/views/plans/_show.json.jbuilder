json.major @plan.major
json.startYear @plan.start_year
json.semesters @plan.semesters do |semester|
  json.set! semester.name do
    json.array! semester.courses do |course|
      json.id course.id
      json.uid course.name
      json.name course.search_name
      json.searchNames course.search_names
      json.dept course.search_dept
      json.number course.number
      json.title course.title
      json.description course.description
      json.postfix course.postfix
      json.units course.units
      json.taggedWith course.rule_list
      json.drag true
    end
  end
end
