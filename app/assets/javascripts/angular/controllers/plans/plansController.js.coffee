#Plans controller

angular.module('ursamajor.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', '$filter', ($scope, $http, $filter) ->
  $scope.semesters = ['fall1','fall2','fall3','fall4','spring1','spring2','spring3','spring4','summer1','summer2','summer3','summer4']
  $scope.garbage = []
  $scope.plan = {}

  # CODE for INTROJS
  $scope.IntroOptions =
    steps: [
      intro: "Hi! Welcome to your planner."
    ,
      intro: "ursaMajor helps you plan your progress towards graduation with a simple drag-and-drop interface."
    ,
      element: "#query"
      intro: "Search here for courses."
      position: "right"
    ,
      element: "#query"
      intro: "Click on a course to get its description."
      position: "right"
    ,
      element: ".backpack"
      intro: "Drag courses to your backpack for later use."
      position: "right"
    ,
      element: "#garbage"
      intro: "Or throw them away in the garbage."
      position: "right"
    ,
      intro: "Drag your courses into the semester planner."
    ,
      element: "#majors select"
      intro: "Select a major."
      position: "left"
    ,
      element: "#rules table"
      intro: "The rules sidebar will instantly show how close you are to satisfying your major requirements."
      position: "left"
    ,
      element: "a.rule.ng-binding"
      intro: "Click to show all courses that fulfill this requirement."
      position: "right"
    ,
      element: "a.result.ng-binding"
      intro: "Click to show all courses in your current plan that fulfill this requirement."
      position: "left"
    ,
      intro: "That's it! Have fun planning. "
    ]
    showStepNumbers: false
    exitOnOverlayClick: true
    exitOnEsc: true
    nextLabel: "<strong>NEXT!</strong>"
    prevLabel: "<span style=\"color:green\">Previous</span>"
    skipLabel: "Exit"
    doneLabel: "Thanks"

  # CODE for Majors
  $scope.majors = [
    "University"
    "LS"
    "Molecular Toxicology"
  ]

  $scope.majorsMapping = 
    "EECS": "COE"
    "Molecular Toxicology": "CNR"
    "LS": "LS"

  $scope.getCollege = (major) ->
    $scope.majorsMapping[major]

  $scope.filterByMajor = (major) ->
    $filter('filter') $scope.rules, (rule) ->
      rule if major in rule["majors"] or $scope.getCollege(major) in rule["colleges"] or rule["university"]

  $scope.updateRules = ->
    $scope.currentRules = $scope.filterByMajor $scope.currentMajor
    $scope.checkRules()

  $scope.$watch 'currentMajor', ->
    $scope.updateRules()

  # BEGIN CoursesController, combinded for duplicate removal for now

  #todo: put garbage course in right place instead of sorting everything (since already sorted at beginning)
  $scope.sortCourses = (a, b) -> switch
      when a.dept > b.dept then 1
      when a.dept < b.dept then -1
      when a.number > b.number then 1
      when a.number < b.number then -1
      when a.postfix > b.postfix then 1
      when a.postfix < b.postfix then -1

  $scope.coursePromise = $http.get("/courses/tagged_courses.json").success (data) ->
    $scope.courses = data
    $scope.courses.sort $scope.sortCourses #todo: sort in rails controller so don't have to here
    $scope.updatePlan()
    $scope.removeDuplicates() #todo: find way to only have to do this once and avoid data race

  $scope.filterCourses = ->
    $filter('filter') $scope.courses, {searchNames: $scope.query}
    # names = $filter('filter') $scope.courses, {searchNames: $scope.query}
    # titles = $filter('filter') $scope.courses, {title: $scope.query}
    # names.concat titles

  $scope.$watchCollection 'garbage', ->
    garbageCourse = $scope.garbage[0]
    $scope.courses.push garbageCourse
    $scope.courses.sort $scope.sortCourses
    $scope.garbage = []

  # END CoursesController

  $scope.dragged = false

  $scope.courseDisplay= (course) ->
    if not $scope.dragged
      $("#course_#{course}").modal('show')
    $scope.dragged = false

  $scope.startDragging = ->
    $scope.dragged = true

  # later make one method for returning garbage to $scope.courses
  $scope.clearSemester = (semester) ->
    if confirm "Clear #{semester}?"
      semesterCourses = $scope[semester]
      $scope[semester] = []
      $scope.courses.push course for course in semesterCourses
      $scope.courses.sort $scope.sortCourses
      $scope.updateUnits()

  $scope.pushToBackpack = (semester) ->
    semesterCourses = $scope[semester]
    $scope[semester] = []
    $scope.backpack.push course for course in semesterCourses
    $scope.updateUnits()

  $scope.findSemester = (data, name) ->
    for semester in data
      return semester[name] if semester[name]
    []

  $scope.taggedWith = (course, rule) ->
    return true if course.uid is rule.name
    for tags in course.taggedWith
      return true if tags is rule.name
    false

  $scope.rulePromise = $http.get("/rules/search.json").success (data) ->
    $scope.rules = data
    $scope.updateRules()

  $scope.checkRule = (rule) ->
    numCourses = numUnits = 0
    fulfillingSet = []
    for course in $scope.plan.courses
      if $scope.taggedWith(course, rule)
        fulfillingSet.push course 
        numCourses += 1
        numUnits += course["units"]
    pass = numUnits >= rule.numUnits and numCourses >= rule.numCourses
    if pass and rule.operator
      for subrule in rule["subrules"]
        if rule.operator == "AND"
          pass = false unless $scope.checkRule(subrule)["pass"]
        if rule.operator == "OR"
          pass = true if $scope.checkRule(subrule)["pass"]
    {
      "pass": pass
      "courses": {id: course["id"], name: course["name"]} for course in fulfillingSet
      "units": numUnits
    }

  $scope.checkRules = ->
    $scope.updatePlan()
    for rule in $scope.currentRules
      rule["result"] = $scope.checkRule rule
    
  $scope.updatePlan = ->
    $scope.plan["courses"] = []
    $scope.plan["backpack"] = $scope["backpack"]
    $scope.plan["major"] = $scope["currentMajor"]
    $scope.plan["startYear"] = $scope["startYear"]
    for semester in $scope.semesters
      $scope.plan[semester] = $scope[semester]
      for course in $scope.plan[semester]
        $scope.plan["courses"].push course
    $scope.planCourses = $scope.plan["courses"].concat $scope.backpack
    $scope.updateUnits()

  $scope.updateUnits = ->
    $scope.units = 0
    for course in $scope.plan["courses"]
      $scope.units += course.units
    for semester in $scope.semesters
      $scope[semester]["units"] = 0
      for course in $scope[semester]
        $scope[semester]["units"] += course.units

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.plan)

  $scope.update = ->
    $scope.checkRules()
    $scope.savePlan()

  $scope.removeDuplicates = ->
    courseIds = (course.id for course in $scope.planCourses)
    $scope.courses = $scope.courses.filter (course) -> course.id not in courseIds

  $scope.startYearString = "2013"
  $scope.years = [
    "2010"
    "2011"
    "2012"
    "2013"
    "2014"
  ]

  $scope.$watch 'startYearString', ->
    $scope.startYear = parseInt $scope.startYearString

  $scope.planPromise = $http.get("#{window.location.pathname}.json").success (data) ->
    $scope.startYearString = data[0]["startYear"]
    $scope.currentMajor = data[0]["major"]
    for section in $scope.semesters.concat ["backpack", "startYearString", "currentMajor"]
      unless section is "startYearString" or section is "currentMajor"
        $scope[section] = $scope.findSemester data, section
      $scope.$watchCollection section, ->
        $scope.update()
    $scope.updatePlan()
    $scope.removeDuplicates()
]