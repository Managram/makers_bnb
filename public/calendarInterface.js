$(document).ready(function() {
  $('.date').pickmeup({
  	flat : true,
  	mode : 'range',
  	format : 'Y-m-d'
  });

  $('#submit').click(function(){
    var dateRange = $('.date').pickmeup('get_date');
    console.log(dateRange);
    $.ajax({
        type:        'POST',
        url:         'http://localhost:4567/reservation',
        data:        {"start_date": dateRange[0],
                     "end_date": dateRange[1]},
        crossDomain: true
    });
  });
});
