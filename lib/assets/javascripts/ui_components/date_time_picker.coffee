angular.module('uiComponents').directive 'dateTimePicker', () ->
  require: '?ngModel',
  restrict: 'AE',
  priority: -1,
  scope: {
    format: "@dateFormat",
    useCurrent: "=dateUseCurrent",
    keepInvalid: "=dateKeepInvalid",
    sideBySide: "=dateSideBySide",
    useStrict: "=dateUseStrict",
    date: "@dateDate"
  },
  link: (scope, elem) ->
    picker =
      elem.datetimepicker(
        format: scope.format,
        useCurrent: scope.useCurrent,
        keepInvalid: scope.keepInvalid,
        sideBySide: scope.sideBySide,
        useStrict: scope.useStrict,
        date: scope.date
      ).data 'DateTimePicker'

    #picker.date(scope.date)

    input = if (elem.is 'input') then elem else elem.find('input:first')
    input.attr('placeholder', scope.format)
    ngModel = input.controller('ngModel')
    ngModel.$setViewValue(scope.date)

#    ngModel.$parsers.push ->
#
#    ngModel.$formatters.push ->

    elem.on 'dp.change', (e) ->
      ngModel.$setViewValue e.date?.format(scope.format)

    scope.$watch 'format', (newValue) ->
      if newValue?
        input.attr('placeholder', newValue)
        picker.format(newValue)

#    scope.$watch 'value', (newValue) ->
#      momentDate = if newValue? then moment(newValue, scope.format, true) else null
#      picker.date momentDate

