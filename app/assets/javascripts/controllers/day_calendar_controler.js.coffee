angular.module('SyncApp').controller 'DayCalendarController', ['$scope', '$http', ($scope, $http) ->

  $scope.init = (date) ->
    $scope.date = moment(date)

  $scope.eventsOn = (date) ->
    (event) ->
      moment(event.startingOn).isSame(date)

  $scope.newEvent = ->
    angular.extend $scope,
      action: 'POST'
      actionUrl: '/events/new'
      event: {}

  $scope.editEvent = (event) ->

]