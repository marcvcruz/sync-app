$(document).ready ->
  $('#start_date_picker')
    .datetimepicker { format: 'L', keepInvalid: true, useCurrent: false, keepOpen: false }
    .on 'dp.change', (e) ->
      $(this).find('input:first').change()
      $(this).data('DateTimePicker').hide()

  $('#start_time_picker')
    .datetimepicker { format: 'LT', keepInvalid: true, useCurrent: true, keepOpen: false }
    .on 'dp.change', (e) ->
      $(this).find('input:first').change()
