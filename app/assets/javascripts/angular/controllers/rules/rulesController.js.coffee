#Rules controller

angular.module('ursamajor.controllers').controller 'RuleDetailCtrl', ['$scope', '$http', ($scope, $http) ->
  
  $scope.sortCourses = (a, b) -> switch
      when a.dept > b.dept then 1
      when a.dept < b.dept then -1
      when a.number > b.number then 1
      when a.number < b.number then -1
      when a.postfix > b.postfix then 1
      when a.postfix < b.postfix then -1

  $scope.coursePromise = $http.get("#{window.location.pathname}.json#{window.location.search}").success (data) ->
    $scope.courses = data
    $scope.courses.sort $scope.sortCourses #todo: sort in rails controller so don't have to here
    $scope.totalDisplayed = 20
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

]