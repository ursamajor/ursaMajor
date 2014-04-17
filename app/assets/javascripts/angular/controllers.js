'use strict';

/* Controllers */

var littledipperControllers = angular.module('littledipperControllers', []);

littledipperControllers.controller('CourseListCtrl', ['$scope', 'Course',
  function($scope, Course) {
    $scope.courses = Course.query();
  }]);

littledipperControllers.controller('CourseDetailCtrl', ['$scope', '$routeParams', 'Course',
  function($scope, $routeParams, Course) {
    $scope.course = Course.get({courseId: $routeParams.courseId});
  }]);