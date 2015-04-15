angular.module('angularValidation').directive 'usernameUniqueness', ($http, $q) ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope, element, attrs, ngModel) ->
    ngModel.$asyncValidators.usernameUniqueness = (modelValue, viewValue) ->
      $http.get '/api/username-uniqueness',
        params:
          username: viewValue
      .then (response) ->
        if response.data.result is 200 then $q.reject('Username already exists in use') else true