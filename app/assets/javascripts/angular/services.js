'use strict';

/* Services */

var littledipperServices = angular.module('littledipperServices', ['ngResource']);

littledipperServices.factory('Course', ['$resource',
  function($resource){
    return $resource('/courses/search?course=:courseId', {}, {
      query: {method:'GET', params:{courseId:'all'}, isArray:true}
    });
  }]);

littledipperServices.factory('Plan', ['$resource',
  function($resource){
    return $resource('/plans/:planId.json', {}, {

    });
  }]);