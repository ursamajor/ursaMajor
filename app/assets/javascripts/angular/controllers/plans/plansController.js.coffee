#Plans controller

angular.module('littledipper.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.semesters = ['backpack','fall1','fall2','fall3','fall4','spring1','spring2','spring3','spring4','summer1','summer2','summer3','summer4']
  $scope.garbage = []
  $scope.plan = {}

  $scope.findSemester = (data, name) ->
    for semester in data
      return semester[name] if semester[name]
    []

  $scope.tagged_with = (course, rule) ->
    for tags in course.tagged_with
      return true if tags is rule.name
    false

  $scope.getRules = ->
    $http.get("/rules/search.json").success (data) ->
      $scope.rules = data
      $scope.checkRules()

  $scope.checkRule = (rule) ->
    numCourses = numUnits = 0
    fulfillingSet = []
    for course in $scope.plan.courses
      if $scope.tagged_with(course, rule)
        fulfillingSet.push course 
        numCourses += 1
        numUnits += course["units"]
    {
      "pass": numUnits >= rule.numUnits and numCourses >= rule.numCourses
      "courses": {id: course["id"], name: course["name"]} for course in fulfillingSet
    }

  $scope.checkRules = ->
    $scope.updatePlan()
    for rule in $scope.rules
      rule["result"] = $scope.checkRule rule
  
  $scope.updatePlan = ->
    $scope.plan["courses"] = []
    for semester in $scope.semesters
      $scope.plan[semester] = $scope[semester]
      unless semester is "backpack"
        for course in $scope.plan[semester]
          $scope.plan["courses"].push course

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.plan).success ->
      $scope.checkRules()

  $scope.update = ->
    $scope.updatePlan()
    $scope.savePlan()

  $scope.getRules()

  $http.get("#{window.location.pathname}.json").success (data) ->
    for semester in $scope.semesters
      $scope[semester] = $scope.findSemester data, semester
      $scope.$watchCollection semester, ->
        $scope.update()
]