$(document).ready(function() {

  function formatDates(dates) {
    var fomattedDates = [];
    $.each(dates, function(index, date){
      var parsedDate = Date.parse(date) - 3600 * 1000;
      fomattedDates.push(new Date(parsedDate));
    })
    return fomattedDates;
  }

  $.ajax({
      type:     'GET',
      url:      'http://localhost:4567/booked-dates',
      dataType: 'json',
  }).then(function(data){
    var bookedDates = data.dates;
    console.log(typeof bookedDates === "array");
    $('.date').pickmeup({
      flat:   true,
      mode:   'range',
      format: 'Y-m-d',
      render: function(date) {
        console.log(bookedDates);
        console.log(date);
        formatDates(bookedDates);

        console.log(formatDates(bookedDates));
        console.log(date);

          if ($.inArray(date, bookedDates) > -1){
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
    console.log(dateRange);
    $.ajax({
      type:    'POST',
      url:     'http://localhost:4567/reservation',
      data:    {"start_date": dateRange[0],
                "end_date": dateRange[1]},
      crossDomain: true
    });
  });
});
// function formatCalendarDates(date) {
//     var d = new Date(date),
//         month = '' + (d.getMonth() + 1),
//         day = '' + d.getDate(),
//         year = d.getFullYear();
//
//     if (month.length < 2) month = '0' + month;
//     if (day.length < 2) day = '0' + day;
//
//     return [year, month, day].join('-');
// }
