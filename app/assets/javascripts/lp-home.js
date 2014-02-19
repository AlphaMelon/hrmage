//
//= require jquery
//= require request_animation_frame
//= require jquery_ujs
//= require jquery.ui.effect-slide
//= require jquery.fullPage
//= require foundation

$(document).ready(function() {

  $.getScript( "<%=asset_path 'jquery.parallax'%>", function( data, textStatus, jqxhr ) {
    $('.scene').parallax();
  })
  $(document).foundation();

  $.fn.fullpage({
    slidesColor: ['#f2f2f2', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],
    anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', 'lastPage']
  });
});