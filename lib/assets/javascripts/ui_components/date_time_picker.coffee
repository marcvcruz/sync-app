angular.module('uiComponents').directive 'dateTimePicker', () ->
  require: '?ngModel',
  restrict: 'AE',
  priority: -1,
  scope: {
    format: '=',
    value: '='
  },
  link: (scope, elem) ->
    picker =
      elem.datetimepicker({ useCurrent: false, keepInvalid: true, sideBySide: true, useStrict: true }).data 'DateTimePicker'

    input = if (elem.is 'input') then elem else elem.find('input:first')
    input.attr('placeholder', scope.format)

    elem.on 'dp.change', (e) ->
      scope.value = e.date?.format(scope.format)

    scope.$watch 'format', (newValue) ->
      input.attr('placeholder', scope.format)
      picker.format(newValue) if newValue?

    scope.$watch 'value', (newValue) ->
      momentDate = if newValue? then moment(newValue, scope.format, true) else null
      picker.date momentDate

