#return empty if query is blank

angular.module('ursamajor.filters').filter 'satisfied', ['$filter', ($filter) ->
  (input) ->
    if input then '\u2713' else '\u2718'
]

angular.module('ursamajor.filters').filter 'color', ['$filter', ($filter) ->
  (input) ->
    if input then "green" else "red"
]
