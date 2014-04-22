#load submodules

angular.module 'littledipper.controllers', []
angular.module 'littledipper.filters', []

#littleDipper Module

littledipper = angular.module 'littledipper', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'littledipper.controllers'
  'littledipper.filters'
]

