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


function ready(){
  $(document).foundation();

  
  $('.date_only').datepicker({
    dateFormat: "yy-mm-dd",
  });

  $('.datetime_only').datetimepicker({
    dateFormat: "yy-mm-dd",
    minDate: -1
  });
  
  if ($( "#account_role option:selected" ).text() == "Admin")
    $("#admin_or_not").show();
  else
    $("#admin_or_not").hide();
  $("#account_role").click(function(){
    if ($( "#account_role option:selected" ).text() == "Admin")
      $("#admin_or_not").show();
    else
      $("#admin_or_not").hide();
   });

  if ($( "#payslip_include_claim option:selected").text() == "Yes")
    $("#include_claim_or_not").show();
  else
    $("#include_claim_or_not").hide();
  $("#payslip_include_claim").click(function(){
    if ($("#payslip_include_claim option:selected").text() == "Yes")
      $("#include_claim_or_not").show();
    else
      $("#include_claim_or_not").hide();
   });

  if ($( "#payslip_include_affected_leave option:selected").text() == "Yes")
    $("#include_leave_or_not").show();
  else
    $("#include_leave_or_not").hide();
  $("#payslip_include_affected_leave").click(function(){
    if ($("#payslip_include_affected_leave option:selected").text() == "Yes")
      $("#include_leave_or_not").show();
    else
      $("#include_leave_or_not").hide();
   });

  if ($( "#leave_type_affected_entity option:selected").text().indexOf("Salary") != -1)
    $("#divide_by_days").show();
  else
    $("#divide_by_days").hide();
  $("#leave_type_affected_entity").click(function(){
    if ($("#leave_type_affected_entity option:selected").text().indexOf("Salary") != -1)
      $("#divide_by_days").show();
    else
      $("#divide_by_days").hide();
   });
   
}


$(document).ready(ready)
$(document).on('page:load', ready)
