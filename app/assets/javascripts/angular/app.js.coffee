#load submodules

angular.module 'littledipper.controllers', []

#littleDipper Module

littledipper = angular.module 'littledipper', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'littledipper.controllers'
]

