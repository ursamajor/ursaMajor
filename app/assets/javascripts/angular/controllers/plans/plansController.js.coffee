#Plans controller

angular.module('littledipper.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.semesters = ['backpack','fall1','fall2','fall3','fall4','spring1','spring2','spring3','spring4','summer1','summer2','summer3','summer4']
  $scope.garbage = []
  $scope.plan = {}

  $scope.find_semester = (data, name) ->
    for semester in data
      return semester[name] if semester[name]
    []
  
  $scope.updatePlan = ->
    for semester in $scope.semesters
      $scope.plan[semester] = $scope[semester]

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.plan).success ->
      $scope.garbage = []
  
  $scope.update_rules = ->
    $http.get("#{window.location.pathname}/check.json").success (data) ->
      $scope.rules = data

  $scope.update = ->
    $scope.updatePlan()
    $scope.savePlan()
    $scope.update_rules()

  $http.get("#{window.location.pathname}.json").success (data) ->
    for semester in $scope.semesters
      $scope[semester] = $scope.find_semester data, semester
      $scope.$watchCollection semester, ->
        $scope.update()
    $scope.update_rules()
]