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

    $scope.$watch('query', function() {
      $scope.filterCourses();
    });

  }]);

// littledipperControllers.controller('CourseDetailCtrl', ['$scope', '$routeParams', 'Course',
//   function($scope, $routeParams, Course) {
//     $scope.course = Course.get({courseId: $routeParams.courseId});
//   }]);

littledipperControllers.controller('PlanListCtrl', ['$scope', 
  function($scope) {

  }]);

littledipperControllers.controller('PlanDetailCtrl', ['$scope', '$http', '$routeParams', 'Plan',
  function($scope, $http, $routeParams, Plan) {
    $scope.garbage = [];

    $scope.find_semester = function(data, semester) {
      for (var i =0; i < data.length; i++) {
        if (data[i][semester]) {
          return data[i][semester];
        }
      }
      return [];
    }

    $scope.getSaveData = function() {
      var saveData = {
        backpack: $scope.backpack,
        fall1: $scope.fall1,
        fall2: $scope.fall2,
        fall3: $scope.fall3,
        fall4: $scope.fall4,
        spring1: $scope.spring1,
        spring2: $scope.spring2,
        spring3: $scope.spring3,
        spring4: $scope.spring4,
        summer1: $scope.summer1,
        summer2: $scope.summer2,
        summer3: $scope.summer3,
        summer4: $scope.summer4
      }
      return saveData;
    }

    $scope.savePlan = function() {
      $http.put(window.location.pathname+'/save', $scope.getSaveData()).success(function() {
        $scope.garbage = [];
      });
    }

    $scope.update_rules = function() {
      $http.get(window.location.pathname+'/check.json').success(function(data) {
        $scope.rules = data;
      });
    }

    $scope.update = function() {
      $scope.savePlan();
      $scope.update_rules();
    }

    $http.get(window.location.pathname+'.json').success(function(data) {
      $scope.backpack = $scope.find_semester(data, "backpack");
      $scope.fall1 = $scope.find_semester(data, "fall1");
      $scope.fall2 = $scope.find_semester(data, "fall2");
      $scope.fall3 = $scope.find_semester(data, "fall3");
      $scope.fall4 = $scope.find_semester(data, "fall4");
      $scope.spring1 = $scope.find_semester(data, "spring1");
      $scope.spring2 = $scope.find_semester(data, "spring2");
      $scope.spring3 = $scope.find_semester(data, "spring3");
      $scope.spring4 = $scope.find_semester(data, "spring4");
      $scope.summer1 = $scope.find_semester(data, "summer1");
      $scope.summer2 = $scope.find_semester(data, "summer2");
      $scope.summer3 = $scope.find_semester(data, "summer3");
      $scope.summer4 = $scope.find_semester(data, "summer4");
      $scope.update_rules();
      $scope.$watchCollection('backpack', function() {
        $scope.update();
      });
      $scope.$watchCollection('fall1', function() {
        $scope.update();
      });
      $scope.$watchCollection('fall2', function() {
        $scope.update();
      });
      $scope.$watchCollection('fall3', function() {
        $scope.update();
      });
      $scope.$watchCollection('fall4', function() {
        $scope.update();
      });
      $scope.$watchCollection('spring1', function() {
        $scope.update();
      });
      $scope.$watchCollection('spring2', function() {
        $scope.update();
      });
      $scope.$watchCollection('spring3', function() {
        $scope.update();
      });
      $scope.$watchCollection('spring4', function() {
        $scope.update();
      });
      $scope.$watchCollection('summer1', function() {
        $scope.update();
      });
      $scope.$watchCollection('summer2', function() {
        $scope.update();
      });
      $scope.$watchCollection('summer3', function() {
        $scope.update();
      });
      $scope.$watchCollection('summer4', function() {
        $scope.update();
      });
    });

  }]);