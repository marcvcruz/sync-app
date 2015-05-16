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
    date: "@dateDate",
    placeholder: "@datePlaceholder"
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

    input = if (elem.is 'input') then elem else elem.find('input:first')
    input.attr('placeholder', scope.placeholder)
    ngModel = input.controller('ngModel')
    elem.on 'dp.change', (e) ->
      ngModel.$setViewValue e.date?.format(scope.format)

    elem.on 'dp.error', ->
      ngModel.$setViewValue input.val() unless picker.options['keepInvalid']
    ngModel.$setViewValue scope.date if angular.isDefined(scope.date)

