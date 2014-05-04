#Landing controller

angular.module('ursamajor.controllers').controller 'LandingCtrl', ['$scope', ($scope) ->
  $scope.slides = [
    {
      text: "All your courses are here"
    }
    {
      text: "A schedule that's personal"
    }
    {
      text: "Degree auditing in an instant"
    }
  ]
]