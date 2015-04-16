angular.module('angularValidation').directive 'confirmedBy', ($timeout) ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope, element, attrs, ngModel) ->
    confirmedBy = element.attr('confirmed-by')
    confirmationElement = angular.element("##{confirmedBy}")
    throw "confirmedBy invalid: no element exists with id #{confirmedBy}" unless confirmationElement.length > 0
    ngModel.$validators.confirmedBy = (modelValue, viewValue) ->
      if !viewValue || !confirmationElement.val() || confirmationElement.val().length == 0
        return true
      confirmationElement.val() == viewValue
    #we have to wait for the ngModel controller to be loaded on the confirmationElement
    $timeout ->
      confirmationModel = confirmationElement.controller('ngModel')
      confirmationModel.$viewChangeListeners.push ->
        ngModel.$validate()