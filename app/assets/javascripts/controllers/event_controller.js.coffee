angular.module('SyncApp').controller 'EventController', ['$rootScope', '$scope', '$http', 'eventService', ($rootScope, $scope, $http, eventService) ->

  $scope.init = ->
    $rootScope.$on 'syncApp.editEvent', ($e, eventSummary) ->
      eventService.getEvent(eventSummary.id).then( (response) ->
        $scope.eventSummary = eventSummary
        $scope.event = response.data
        angular.element('#event_form').modal('show')
      )

    $rootScope.$on 'syncApp.createEvent', ->
      $scope.event = {}
      angular.element('#event_form').modal('show')

  $scope.submit = (e) ->
    e.preventDefault()
    eventService.saveEvent($scope.event).then( ->
      angular.element('#event_form').modal('hide')
      $rootScope.$broadcast 'syncApp.eventsChanged', { oldValue: $scope.eventSummary, newValue: $scope.event }
      $scope.event = undefined
      $scope.eventSummary = undefined
      angular.element('#event_form').modal('hide')

    )
]