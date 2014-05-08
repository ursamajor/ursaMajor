#Courses controller

angular.module('ursamajor.controllers').controller 'CourseListCtrl', ['$scope', '$http', '$filter', ($scope, $http, $filter) ->
  
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
    $scope.totalDisplayed = 20
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

  $scope.courseDisplay= (course) ->
    $("#course_#{course}").modal('show')

  $scope.$watch 'query', ->
    $scope.totalDisplayed = 20
]