angular.module('SyncApp').controller 'MonthlyCalendarController', ['$scope', '$http', ($scope, $http) ->

  $scope.init = (date) ->
    startDate = moment(date)
    $http.get "/calendar/#{startDate.year()}/#{startDate.month() + 1}",
      headers: 'Accept': 'application/json'
    .success (data) ->
      $scope.events = data
    .error (e) ->
      console.log 'An error occured.'

]