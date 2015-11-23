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

function buildChart(months, totais) {
  var monthlabels = [];
  var values = [];

  months.forEach(function(value) {
    monthlabels.push(value.table.name);
  });

  totais.forEach(function(value) {
    values.push(value);
  });

  console.log(monthlabels);
  console.log(values);

  var data = {
    // A labels array that can contain any sort of values
    labels: monthlabels,
    // Our series array that contains series objects or in this case series data arrays
    series: [
      values
    ]
  };

  var options = {
    low: 0,
    onlyInteger: true
  };

  // Create a new line chart object where as first parameter we pass in a selector
  // that is resolving to our chart container element. The Second parameter
  // is the actual data object.
  new Chartist.Line('.ct-chart', data, options);
}
