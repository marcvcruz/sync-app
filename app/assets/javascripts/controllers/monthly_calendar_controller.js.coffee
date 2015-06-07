angular.module('SyncApp').controller 'MonthlyCalendarController', ['$scope', '$http', ($scope, $http) ->

  $scope.init = (date) ->
    startDate = moment(date)
    $http.get "/calendar/#{startDate.year()}/#{startDate.month() + 1}.json",
      headers: 'Accept': 'application/json'
    .success (data) ->
      $scope.eventsThisMonth = data
    .error (e) ->
      console.log 'An error occured.'

]