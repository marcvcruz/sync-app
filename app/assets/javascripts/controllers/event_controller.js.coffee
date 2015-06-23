angular.module('SyncApp').controller 'EventController', ['$scope', '$http', ($scope, $http) ->

  eventModal = angular.element('#event_form.modal')

  $scope.newEvent = ->
    angular.extend $scope,
      action: 'POST'
      actionUrl: '/events/new'
      event: {}
    eventModal.modal('show')

  $scope.editEvent = (event) ->
    $http.get "/calendar/#{year}/#{month}.json",
      headers: 'Accept': 'application/json'
    .success (data) ->
      $scope.events = data
    .error (e) ->
      console.log 'An error occured.'

  $scope.submit = (e) ->
    e.preventDefault()

    $http
      headers: 'Accept': 'application/json'
      method: $scope.action
      url: $scope.actionUrl
      data: { eventForm: $scope.event }
    .error (e) ->
      console.log 'An error occured'
    .finally (e) ->
      eventModal.modal('hide')
      $scope.event = undefined
      $scope.action = ''
      $scope.actionUrl = ''
]