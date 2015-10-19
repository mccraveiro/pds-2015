function ready () {
  $('.selectpicker').selectpicker({
    style: 'btn-default btn-lg',
    width: '100%'
  });

  $('.selectpicker').change(function() {
    $('#filter-form').submit();
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
