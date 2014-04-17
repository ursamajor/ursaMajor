'use strict';

/* Services */

var littledipperServices = angular.module('littledipperServices', ['ngResource']);

littledipperServices.factory('Course', ['$resource',
  function($resource){
    return $resource('/courses/:courseId.json', {}, {
      query: {method:'GET', params:{courseId:'all'}, isArray:true}
    });
  }]);