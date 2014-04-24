#Plans controller

angular.module('littledipper.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', '$filter', ($scope, $http, $filter) ->
  $scope.semesters = ['backpack','fall1','fall2','fall3','fall4','spring1','spring2','spring3','spring4','summer1','summer2','summer3','summer4']
  $scope.garbage = []
  $scope.plan = {}

  # BEGIN CoursesController, combinded for duplicate removal for now

  #todo: put garbage course in right place instead of sorting everything (since already sorted at beginning)
  $scope.sortCourses = (a, b) -> switch
      when a.dept > b.dept then 1
      when a.dept < b.dept then -1
      when a.number > b.number then 1
      when a.number < b.number then -1
      when a.postfix > b.postfix then 1
      when a.postfix < b.postfix then -1

  $http.get("/courses/tagged_courses.json").success (data) ->
    $scope.courses = data
    $scope.courses.sort $scope.sortCourses #todo: sort in rails controller so don't have to here
    $scope.updatePlan()
    $scope.removeDuplicates() #todo: find way to only have to do this once and avoid data race
    $scope.totalDisplayed = 20
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

  $scope.filterCourses = ->
    $filter('filter') $scope.courses, $scope.query

  $scope.$watchCollection 'garbage', ->
    garbageCourse = $scope.garbage[0]
    $scope.courses.push garbageCourse
    $scope.courses.sort $scope.sortCourses
    $scope.garbage = []

  $scope.$watch 'query', ->
    $scope.totalDisplayed = 20

  # END CoursesController

  # later make one method for returning garbage to $scope.courses
  $scope.clearSemester = (semester) ->
    semesterCourses = $scope[semester]
    $scope[semester] = []
    $scope.courses.push course for course in semesterCourses
    $scope.courses.sort $scope.sortCourses

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
    $scope.updateUnits()

  $scope.updateUnits = ->
    $scope.units = 0
    for course in $scope.plan["courses"]
      $scope.units += course.units

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.plan)

  $scope.update = ->
    $scope.checkRules()
    $scope.savePlan()

  $scope.removeDuplicates = ->
    $scope.planCourses = $scope.plan["courses"].concat $scope.backpack
    $scope.planCourses = (course.id for course in $scope.planCourses)
    $scope.courses = $scope.courses.filter (course) -> course.id not in $scope.planCourses

  $scope.getRules()

  $http.get("#{window.location.pathname}.json").success (data) ->
    for semester in $scope.semesters
      $scope[semester] = $scope.findSemester data, semester
      $scope.$watchCollection semester, ->
        $scope.update()
    $scope.updatePlan()
    $scope.removeDuplicates()
]