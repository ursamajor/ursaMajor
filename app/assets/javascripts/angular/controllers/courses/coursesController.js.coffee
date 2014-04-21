#Courses controller

angular.module('littledipper.controllers').controller 'CourseListCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.courses = []
  $scope.totalDisplayed = 20
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

  $scope.filterCourses = ->
    $http.get("/courses/search?course=#{$scope.query}").success (data) ->
      $scope.courses = if $scope.query is '' then [] else data
      $scope.totalDisplayed = 20

  $scope.$watch 'query', ->
    $scope.filterCourses()
]