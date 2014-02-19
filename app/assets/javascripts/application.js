// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require jquery-ui-timepicker-addon
//= require hrmage

var t;
function ready(){
  $(document).foundation();
  
  $('.date_only').datepicker({
    dateFormat: "yy-mm-dd",
  });

  $('.datetime_only').datetimepicker({
    dateFormat: "yy-mm-dd",
    minDate: -1
  });
}

$(document).ready(ready)
$(document).on('page:load', ready)
