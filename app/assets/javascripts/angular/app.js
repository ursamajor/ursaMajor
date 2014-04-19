'use strict';

/* littleDipper Module */

var littledipperApp = angular.module('littledipperApp', [
  'ngRoute',
  // 'littledipperAnimations',
  'littledipperControllers',
  // 'littledipperFilters',
  'littledipperServices',
  'ngDragDrop',
  'infinite-scroll'
]);

// littledipperApp.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/courses', {
//         templateUrl: 'assets/course-list.html.haml',
//         controller: 'CourseListCtrl'
//       }).
//       when('/courses/:courseId', {
//         templateUrl: 'assets/course-detail.html.haml',
//         controller: 'CourseDetailCtrl'
//       }).
//       when('/', {
//         templateUrl: 'assets/plan-list.html.haml',
//         controller: 'PlanListCtrl'
//       }).
//       when('/:planId', {
//         templateUrl: 'assets/plan-detail.html.haml',
//         controller: 'PlanDetailCtrl'
//       });
//   }]);