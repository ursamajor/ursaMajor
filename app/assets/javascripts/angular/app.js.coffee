#load submodules

angular.module 'ursamajor.controllers', []
angular.module 'ursamajor.filters', []

#ursaMajor Module

ursamajor = angular.module 'ursamajor', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'ui.bootstrap'
  'angular-intro'
  'cgBusy'
  'chieffancypants.loadingBar'
  'ursamajor.controllers'
  'ursamajor.filters'
]

