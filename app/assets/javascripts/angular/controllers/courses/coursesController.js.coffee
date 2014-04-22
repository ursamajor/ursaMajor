#Courses controller

angular.module('littledipper.controllers').controller 'CourseListCtrl', ['$scope', '$http', ($scope, $http) ->
  
  $http.get("/courses/search?course=all").success (data) ->
    $scope.totalDisplayed = 20
    $scope.courses = data
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

  $scope.$watch 'query', ->
    $scope.totalDisplayed = 20
]