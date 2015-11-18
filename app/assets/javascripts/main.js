function ready () {
  $('.selectpicker').selectpicker({
    style: 'btn-default btn-lg',
    width: '100%'
  });

  $('.selectpicker').change(function() {
    $('#filter-form').find('input[name="first"]').val(1);
    $('#filter-form').submit();
  });

  $("#pagPrevious").click(function(){
    var x = parseInt($('#filter-first').val()) - 10;
    $('#filter-form').find('input[name="first"]').val(x);
    $('#filter-form').submit();
  });

  $("#pagNext").click(function(){
    var x = parseInt($('#filter-first').val()) + 10;
    $('#filter-form').find('input[name="first"]').val(x);
    $('#filter-form').submit();
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
