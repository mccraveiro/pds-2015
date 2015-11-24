function ready () {

  $('.tabs .tab-links a').on('click', function(e)  {
    var currentAttrValue = $(this).attr('href');

    // Show/Hide Tabs
    $('.tabs ' + currentAttrValue).show().fadeIn(400).siblings().hide();
    // Change/remove current tab to active
    $(this).parent('li').addClass('active').siblings().removeClass('active');

    $(currentAttrValue).find('.ct-chart').each(function() {
      this.__chartist__.update();
    });

    e.preventDefault();
  });


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

function buildChart(months, totais, logged) {
  var monthlabels = [];
  var values = [];
  var i = 0;

  months.forEach(function(value) {
    monthlabels.push(value.table.name);
  });

  totais.forEach(function(value) {
    values.push({
      "meta": monthlabels[i],
      "value": value
    });
    i++;
  });

  console.log(monthlabels);
  console.log(values);


  var dataLineBar = {
    labels: monthlabels,
    series: [values]
  };
  if (logged) {
    var optionsLine = {
      low: 0,
      onlyInteger: true,
      height: '400px',
      plugins: [
        Chartist.plugins.tooltip()
      ]
    };
  } else {
    var optionsLine = {
      low: 0,
      onlyInteger: true,
      height: '400px'
    };
  }


  var dataPie = {
    labels: monthlabels,
    series: values
  };
  if (logged) {
    var options = {
      onlyInteger: true,
      height: '400px',
      plugins: [
        Chartist.plugins.tooltip()
      ]
    };
  } else {
    var options = {
      onlyInteger: true,
      height: '400px'
    };
  }


  // Create a new line chart object where as first parameter we pass in a selector
  // that is resolving to our chart container element. The Second parameter
  // is the actual data object.
  new Chartist.Line('#chart1', dataLineBar, optionsLine);
  new Chartist.Pie('#chart2', dataPie, options);
  new Chartist.Bar('#chart3', dataLineBar, options);

}


function comparisonBuildCharts(months, totais, logged) {
  var monthlabels = [];
  var totais1 = totais[1];
  var totais2 = totais[2];
  var values1 = [];
  var values2 = [];
  var i = 0;

  months.forEach(function(value) {
    monthlabels.push(value.table.name);
  });

  console.log(totais1);

  totais1.forEach(function(value) {
    values1.push({
      "meta": "Busca 1 - " + monthlabels[i],
      "value": value
    });
    i++;
  });


  i = 0;
  totais2.forEach(function(value) {
    values2.push({
      "meta": "Busca 2 - " + monthlabels[i],
      "value": value
    });
    i++;
  });


  var dataLine = {
    labels: monthlabels,
    series: [values1, values2]
  };
  if (logged) {
    var options = {
      low: 0,
      onlyInteger: true,
      height: '400px',
      plugins: [
        Chartist.plugins.tooltip()
      ]
    };
  } else {
    var options = {
      low: 0,
      onlyInteger: true,
      height: '400px'
    };
  }



  // Create a new line chart object where as first parameter we pass in a selector
  // that is resolving to our chart container element. The Second parameter
  // is the actual data object.
  new Chartist.Line('#chartComparison', dataLine, options);

}
