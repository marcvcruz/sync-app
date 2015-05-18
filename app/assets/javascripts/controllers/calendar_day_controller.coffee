angular.module('SyncApp').controller 'CalendarDayController', ['$scope', ($scope) ->

  $scope.init = (date) ->
    $scope.date = moment(date)
]