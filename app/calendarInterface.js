$(document).ready(function() {

  $('.date').pickmeup({
  	flat : true,
  	mode : 'range',
  	format : 'Y-m-d'
  });

  $('#submit').click(function(){
  	console.log($('.date').pickmeup('get_date') );
  });

});