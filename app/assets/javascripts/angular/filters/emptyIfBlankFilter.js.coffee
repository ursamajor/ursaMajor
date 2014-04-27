#return empty if query is blank

angular.module('ursamajor.filters').filter 'emptyIfBlank', ['$filter', ($filter) ->
  (object, query) ->
    if not query then {} else object
]