
window.onload = function(){
  init();

  $(document).on('ready page:load turbolinks:load', function () {
    init();
  });
}

function init(){
  var date = new Date();
  $("#task_start_date").datepicker({
  	format: 'dd/M/yyyy',
  	startDate: date 
  });
  $("#task_due_date").datepicker({
  	format: 'dd/M/yyyy',
  	startDate: date 
  });
}