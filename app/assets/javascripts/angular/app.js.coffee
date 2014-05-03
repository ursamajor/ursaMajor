#load submodules

angular.module 'ursamajor.controllers', []
angular.module 'ursamajor.filters', []

#ursaMajor Module

ursamajor = angular.module 'ursamajor', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'ursamajor.controllers'
  'ursamajor.filters'
  'angular-intro'
]

