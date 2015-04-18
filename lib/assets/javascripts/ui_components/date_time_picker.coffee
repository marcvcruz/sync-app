angular.module('uiControls').directive 'dateTimePicker', ($parse) ->
  priority: -1
  require: 'ngModel'
  restrict: 'A'
  link: (scope, element, attrs, ngModel) ->
    config =
      format: 'L'
      keepInvalid: true
      useCurrent: false
      keepOpen: false
    element.datetimepicker config
    input = element.find('input:first')
    throw 'datetimepicker requires an input child element' unless input?
    ngModel = input.controller('ngModel')
    element.on 'dp.change', (e) ->
      ngModel.$setViewValue e.date?.format('MM/DD/YYYY') #need to set view value to the formatted version
      scope.$apply()

    scope.$watch attrs.ngModel, (newValue, oldValue) ->
      element.datetimepicker().date(newValue) if angular.isDate(newValue) # need to set the datepicker to the formatted version
