'use strict';

/* Controllers */

var littledipperControllers = angular.module('littledipperControllers', []);

littledipperControllers.controller('CourseListCtrl', ['$scope', 'Course',
  function($scope, Course) {
    $scope.courses = Course.query();
    // $scope.displayedCourses = [];
   
    // $scope.addMoreCourses = function() {
    //   var start = $scope.displayedCourses.length
    //   var last = $scope.courses.length - 1
    //   for(var i = start; i <= start + 30 && i <= last; i++) {
    //     $scope.displayedCourses.push($scope.courses[i]);
    //   }
    // };
  }]);

littledipperControllers.controller('CourseDetailCtrl', ['$scope', '$routeParams', 'Course',
  function($scope, $routeParams, Course) {
    $scope.course = Course.get({courseId: $routeParams.courseId});
  }]);