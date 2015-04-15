angular.module('angularValidation').directive 'submitOnValid', ->
  restrict: 'A'
  require: 'form'
  link: (scope, element, attrs, controller) ->
    ensureModelUpToDate = ->
      element.find('input[ng-model]').each (index, item) ->
        input = angular.element(this)
        if input.attr('type') != 'checkbox' && input.attr('type') != 'radio'
          input.controller('ngModel').$setViewValue(input.val())

    element.on 'submit', (e) ->
      scope.$apply ->
        ensureModelUpToDate()
        controller.$setSubmitted()
        if !controller.$valid
          e.preventDefault()
          firstInvalid = element.find('.ng-invalid:visible').first()
          if firstInvalid
            firstInvalid.focus()
      true