#load submodules

angular.module 'ursamajor.controllers', []
angular.module 'ursamajor.filters', []

#ursaMajor Module

ursamajor = angular.module 'ursamajor', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'angular-intro'
  'ursamajor.controllers'
  'ursamajor.filters'
  'angular-intro'
]

