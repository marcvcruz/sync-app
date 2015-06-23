angular.module('SyncApp').controller 'MonthlyCalendarController', ['$scope', '$http', ($scope, $http) ->

  getEventControllerScope = ->
    angular.element('#event_form [ng-controller=EventController').scope()

  $scope.events = []

  $scope.init = (month, year) ->
    $http.get "/calendar/#{year}/#{month}.json",
      headers: 'Accept': 'application/json'
    .success (data) ->
      $scope.events = data
    .error (e) ->
      console.log 'An error occured.'
]