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
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require jquery.ui.all
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require jquery-ui-timepicker-addon
//= require jquery-ui-sliderAccess
//= require_tree .
//= require jquery-ui-timepicker-addon
//= require jquery-ui-sliderAccess
//= require jquery.slimscroll.min
//= require jquery.fullPage
// var t;
// function ready(){
//   t = setTimeout(function(){$(document).foundation()},500);
// }

// $(document).ready(ready)
// $(document).on('page:load', ready)
// $(document).on('page:fetch', function(){
//   clearTimeout(t);
// })

$(function(){ $(document).foundation(); });

$(function() {
    $('#leave_start_date').datetimepicker({
      dateFormat: "yy-mm-dd",
      minDate: -1
    });
  });

$(function() {
    $('.date_only').datepicker({
      dateFormat: "yy-mm-dd",
    });
  });



