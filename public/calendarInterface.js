$(document).ready(function() {

  function formatDates(dates) {
    var formattedDates = new Array();
    $.each(dates, function(index, date){
      var parsedDate = Date.parse(date) - 3600 * 1000;
      var newDate    = new Date(parsedDate);
      formattedDates.push(newDate.toString());
    })
    return formattedDates;
  }

  var spaceId = $('h2').attr('id');

  $.ajax({
      type:     'GET',
      url:      'http://localhost:9292/booked-dates/'+spaceId+'',
      dataType: 'json',
  }).then(function(data){
    $('.date').pickmeup({
      flat:       true,
      mode:       'range',
      format:     'Y-m-d',
      calendars:  1,
      render:     function(date) {
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
    var spaceId = $('h2').attr('id');
    $.ajax({
      type:    'POST',
      url:     'http://localhost:9292/reservation',
      data:    {"start_date": dateRange[0],
                "end_date": dateRange[1],
                "space_id": spaceId },
      crossDomain: true
    });
  });
});
