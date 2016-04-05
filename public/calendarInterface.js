$(document).ready(function() {

  function formatDates(dates) {
    var formattedDates = new Array();
    $.each(dates, function(index, date){
      var parsedDate = Date.parse(date) - 3600 * 1000;
      var newDate = new Date(parsedDate)
      formattedDates.push(newDate.toString());
    })
    return formattedDates;
  }

  $.ajax({
      type:     'GET',
      url:      'http://localhost:4567/booked-dates',
      dataType: 'json',
  }).then(function(data){
    $('.date').pickmeup({
      flat:   true,
      mode:   'range',
      format: 'Y-m-d',
      render: function(date) {
        var bookedDates = formatDates(data.dates);
        if ($.inArray(date.toString(), bookedDates) > -1){
          return {
            disabled   : true,
            class_name : 'disabled'
          }
        }
      }
    });
  });

  $('#submit').click(function(){
    var dateRange = $('.date').pickmeup('get_date');
    $.ajax({
      type:    'POST',
      url:     'http://localhost:4567/reservation',
      data:    {"start_date": dateRange[0],
                "end_date": dateRange[1]},
      crossDomain: true
    });
  });
});
