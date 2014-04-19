'use strict';

/* Controllers */

var littledipperControllers = angular.module('littledipperControllers', []);

littledipperControllers.controller('CourseListCtrl', ['$scope', '$http',
  function($scope, $http) {
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

    $("#query").keyup(function() {
      $scope.filterCourses();
    });

  }]);

// littledipperControllers.controller('CourseDetailCtrl', ['$scope', '$routeParams', 'Course',
//   function($scope, $routeParams, Course) {
//     $scope.course = Course.get({courseId: $routeParams.courseId});
//   }]);

littledipperControllers.controller('PlanDetailCtrl', ['$scope', '$http',
  function($scope, $http) {
    $scope.backpack = [];
    $scope.fall1 = [];
    $scope.fall2 = [];
    $scope.fall3 = [];
    $scope.fall4 = [];
    $scope.spring1 = [];
    $scope.spring2 = [];
    $scope.spring3 = [];
    $scope.spring4 = [];
    $scope.summer1 = [];
    $scope.summer2 = [];
    $scope.summer3 = [];
    $scope.summer4 = [];
  }]);