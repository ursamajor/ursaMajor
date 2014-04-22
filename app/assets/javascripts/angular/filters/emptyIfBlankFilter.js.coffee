#return empty if query is blank

angular.module('littledipper.filters').filter 'emptyIfBlank', ['$filter', ($filter) ->
  (object, query) ->
    if not query then {} else object
]