$(document).ready ->
  $('#event_starting_at_container')
    .datetimepicker { format: 'YYYY-MM-DD hh:mm A', sideBySide: true, keepInvalid: true, useCurrent: false }
    .on 'dp.change', (e) ->
      $(this).find('input:first').change()
