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
//         templateUrl: '/courses/index.html.haml',
//         controller: 'CourseListCtrl'
//       }).
//       when('/courses/:courseId', {
//         templateUrl: '..courses/show.html.haml',
//         controller: 'CourseDetailCtrl'
//       }).
//       when('/', {
//         templateUrl: 'assets/plan-list.html.haml',
//         controller: 'PlansListCtrl'
//       }).
//       when('/:planId', {
//         templateUrl: 'assets/plan-detail.html.haml',
//         controller: 'PlanDetailCtrl'
//       });
//   }]);