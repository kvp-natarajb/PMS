window.onload = function(){
  init();

  $(document).on('ready page:load turbolinks:load', function () {
    init();
  });
}


function init(){
  var date = new Date();
  console.log('entered')
  $("#project_start_date").datepicker({ 
  	format: 'dd/M/yyyy',
  	startDate: date 
  });
  $("#project_due_date").datepicker({ 
  	format: 'dd/M/yyyy',
  	startDate: date 
  });
}