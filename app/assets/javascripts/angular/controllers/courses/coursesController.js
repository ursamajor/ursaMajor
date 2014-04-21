'use strict';

/* Courses controller */

angular.module('littledipper.controllers').controller('CourseListCtrl', ['$scope', '$http', function($scope, $http) {
  $scope.courses = [];
  $scope.totalDisplayed = 20;
 
  $scope.addMoreCourses = function() {
    $scope.totalDisplayed += 30;
  };

  $scope.filterCourses = function() {
    $http.get('/courses/search?course='+$scope.query).success(function(data) {
      if ($scope.query == '') {
        $scope.courses = [];
      } else {
        $scope.courses = data;
      }
      $scope.totalDisplayed = 20;
    });
  }

  $scope.$watch('query', function() {
    $scope.filterCourses();
  });

}]);