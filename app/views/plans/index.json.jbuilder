json.plans do
  json.array! @plans do |plan|
    json.name plan.name
    json.courses do
      json.array! plan.courses
    end
  end
end