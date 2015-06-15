angular.module('SyncApp').controller 'MonthlyCalendarController', ['$scope', '$http', ($scope, $http) ->

  $scope.events = []

  $scope.init = (date) ->
    startDate = moment(date)
    $http.get "/calendar/#{startDate.year()}/#{startDate.month() + 1}.json",
      headers: 'Accept': 'application/json'
    .success (data) ->
      $scope.events = data
    .error (e) ->
      console.log 'An error occured.'

  $scope.eventsOn = (date) ->
    (event for event in $scope.events when moment(event.startingDate).isSame(date))
]