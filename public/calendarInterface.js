$(document).ready(function() {
  
  
  $.ajax({
      type:        'GET',
      url:         'http://localhost:4567/booked-dates',
    }).then(function(data){
      // console.log(data);
     ourArray = data;

    $('.date').pickmeup({
    flat : true,
    mode : 'range',
    format : 'Y-m-d',
    render: function(date) {
      console.log(ourArray);
      formatDates(ourArray);
      console.log(formatDates(ourArray));
      console.log(date);
            if ($.inArray(date, ourArray) > -1){
              //console.log(ourArray);
                return {
                    disabled   : true,
                    class_name : 'disabled'
                }
            }
        }    
    });

  });

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


function formatDates(myarray) {
  var thisArray = [];
  $.each([myarray], function(date){
   var newDate = Date.parse(date);
   var work = new Date(newDate);
   thisArray.push(work); 
  })
  return thisArray;
}

function formatCalendarDates(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}


