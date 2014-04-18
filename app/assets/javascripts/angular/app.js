'use strict';

/* littleDipper Module */

var littledipperApp = angular.module('littledipperApp', [
  'ngRoute',
  // 'littledipperAnimations',
  'littledipperControllers',
  // 'littledipperFilters',
  'littledipperServices',
  'infinite-scroll'
]);

// littledipperApp.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/courses', {
//         templateUrl: 'courses/index.html.haml',
//         controller: 'CourseListCtrl'
//       }).
//       when('/courses/:courseId', {
//         templateUrl: 'courses/show.html.haml',
//         controller: 'CourseDetailCtrl'
//       }).
//       otherwise({
//         redirectTo: '/courses'
//       });
//   }]);