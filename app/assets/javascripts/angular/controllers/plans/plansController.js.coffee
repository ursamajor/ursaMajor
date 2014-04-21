#Plans controller

angular.module('littledipper.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.garbage = []

  $scope.find_semester = (data, name) ->
    for semester in data
      return semester[name] if semester[name]
    []
  
  $scope.getSaveData = ->
    saveData = 
      backpack: $scope.backpack
      fall1: $scope.fall1
      fall2: $scope.fall2
      fall3: $scope.fall3
      fall4: $scope.fall4
      spring1: $scope.spring1
      spring2: $scope.spring2
      spring3: $scope.spring3
      spring4: $scope.spring4
      summer1: $scope.summer1
      summer2: $scope.summer2
      summer3: $scope.summer3
      summer4: $scope.summer4

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.getSaveData()).success ->
      $scope.garbage = []
  
  $scope.update_rules = ->
    $http.get("#{window.location.pathname}/check.json").success (data) ->
      $scope.rules = data

  $scope.update = ->
    $scope.savePlan()
    $scope.update_rules()

  $http.get("#{window.location.pathname}.json").success (data) ->
    $scope.backpack = $scope.find_semester data, "backpack"
    $scope.fall1 = $scope.find_semester data, "fall1"
    $scope.fall2 = $scope.find_semester data, "fall2"
    $scope.fall3 = $scope.find_semester data, "fall3"
    $scope.fall4 = $scope.find_semester data, "fall4"
    $scope.spring1 = $scope.find_semester data, "spring1"
    $scope.spring2 = $scope.find_semester data, "spring2"
    $scope.spring3 = $scope.find_semester data, "spring3"
    $scope.spring4 = $scope.find_semester data, "spring4"
    $scope.summer1 = $scope.find_semester data, "summer1"
    $scope.summer2 = $scope.find_semester data, "summer2"
    $scope.summer3 = $scope.find_semester data, "summer3"
    $scope.summer4 = $scope.find_semester data, "summer4"
    $scope.update_rules()
    $scope.$watchCollection 'backpack', ->
      $scope.update()
    $scope.$watchCollection 'fall1', ->
      $scope.update()
    $scope.$watchCollection 'fall2', ->
      $scope.update()
    $scope.$watchCollection 'fall3', ->
      $scope.update()
    $scope.$watchCollection 'fall4', ->
      $scope.update()
    $scope.$watchCollection 'spring1', ->
      $scope.update()
    $scope.$watchCollection 'spring2', ->
      $scope.update()
    $scope.$watchCollection 'spring3', ->
      $scope.update()
    $scope.$watchCollection 'spring4', ->
      $scope.update()
    $scope.$watchCollection 'summer1', ->
      $scope.update()
    $scope.$watchCollection 'summer2', ->
      $scope.update()
    $scope.$watchCollection 'summer3', ->
      $scope.update()
    $scope.$watchCollection 'summer4', ->
      $scope.update()
]