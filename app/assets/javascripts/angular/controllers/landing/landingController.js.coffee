#Landing controller

angular.module('ursamajor.controllers').controller 'LandingCtrl', ['$scope', ($scope) ->
  
  $scope.IntroOptions = {
    steps: [
      {
        element: '#step1',
        intro: "First tooltip"
      },
      {
        element: '#step4',
        intro: "Second tooltip",
        position: 'right'
      }
    ]
  }
]