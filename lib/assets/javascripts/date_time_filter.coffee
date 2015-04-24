angular.module('components', []).directive 'dateTimeFilter', () ->
  priority: -1
  require: 'ngModel'
  restrict: 'A'
  link: (scope, element, attrs, ngModel) ->
    format = attrs.dateTimeFilter or 'MM/DD/YYYY'
    ngModel.$formatters.push (value) ->
      moment(value).format(format) if value? and angular.isDate(value)

    ngModel.$parsers.push (value) ->
      moment(value, format).toDate() if value? and angular.isString(value)
