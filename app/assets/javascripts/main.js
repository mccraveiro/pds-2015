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

  $('.float-button').click(function() {
    $.post('/add-favorite', {
      user_id: $('#user_id').val(),
      domain: $('#filter-domain').val(),
      subdomain: $('#filter-subdomain').val(),
      nature: $('#filter-nature').val(),
      city: $('#filter-city').val(),
      month: $('#filter-month').val(),
      year: $('#filter-year').val()
    }, function (data) {
      alert('Favorito adicionado com sucesso!');
    });
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
