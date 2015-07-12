angular.module('SyncApp').controller 'MonthlyCalendarController', ['$rootScope', '$scope', 'eventService', ($rootScope, $scope, eventService) ->

  $scope.events = []

  $scope.init = (year, month) ->
    $rootScope.$on('syncApp.eventsChanged', ($e, params) ->
      $scope.events.add(params.newValue) unless params.oldValue?
      if moment(params.oldValue.startingOn).isSame(params.newValue.startingOn)
        angular.extend(params.oldValue, params.newValue)
      else
        index = $scope.events.indexOf params.oldValue
        $scope.events.splice(index, 1)
        $scope.events.push params.newValue
    )
    $scope.getEvents(year, month)

  $scope.getEvents = (year, month) ->
    eventService.getEvents(year, month).then( (response) ->
      $scope.events = response.data
    )

  $scope.eventsOn = (date) ->
    (event) ->
      moment(event.startingOn).isSame(date)

  $scope.editEvent = (event)->
    $rootScope.$broadcast 'syncApp.editEvent', event
]