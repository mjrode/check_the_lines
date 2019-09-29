$(document).on('turbolinks:load', function() {
  $('#datetimepicker').datetimepicker({
    locale: 'fr',
    sideBySide: true,
    format: 'DD-MM-YYYY h:mm A'
  });
});
