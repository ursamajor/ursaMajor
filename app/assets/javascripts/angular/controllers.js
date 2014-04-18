'use strict';

/* Controllers */

var littledipperControllers = angular.module('littledipperControllers', []);

littledipperControllers.controller('CourseListCtrl', ['$scope', '$http',
  function($scope, $http) {
    $scope.courses = [];
    $scope.totalDisplayed = 20;
   
    $scope.addMoreCourses = function() {
      if ($scope.totalDisplayed < 100) {
        $scope.totalDisplayed += 20;
      }
    };

    $scope.filterCourses = function() {
      $http.get('/courses/search?course='+$scope.query).success(function(data) {
        if ($scope.query == '') {
          $scope.courses = [];
        } else {
          $scope.courses = data;
        }
      });
    }

    $("#query").keyup(function() {
      $scope.filterCourses();
    });

  }]);

// littledipperControllers.controller('CourseDetailCtrl', ['$scope', '$routeParams', 'Course',
//   function($scope, $routeParams, Course) {
//     $scope.course = Course.get({courseId: $routeParams.courseId});
//   }]);