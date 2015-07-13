angular.module('SyncApp').controller 'EventController', ['$rootScope', '$scope', '$http', 'eventService', ($rootScope, $scope, $http, eventService) ->

  $scope.init = ->
    angular.element('#event_form').on 'hide.bs.modal', ->
      $scope.event = undefined
      $scope.eventSummary = undefined
      $scope.eventForm.$setPristine()
      $scope.eventForm.$setUntouched()

    $rootScope.$on 'syncApp.editEvent', ($e, eventSummary) ->
      eventService.getEvent(eventSummary.id).then( (response) ->
        $scope.eventSummary = eventSummary
        $scope.event = response.data
        angular.element('#event_form').modal('show')
      )

    $rootScope.$on 'syncApp.createEvent', ($e, date) ->
      $scope.eventSummary = undefined
      $scope.event = {}
      $scope.event.startingOn = moment(date).format('MM/DD/YYYY') if date?
      angular.element('#event_form').modal('show')

  $scope.submit = (e) ->
    e.preventDefault()
    if $scope.eventForm.$valid
      eventService.saveEvent($scope.event).then( ->
        $rootScope.$broadcast 'syncApp.eventsChanged', { oldValue: $scope.eventSummary, newValue: $scope.event }
        angular.element('#event_form').modal('hide')
      )
]