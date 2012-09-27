$(document).ready(function() {
  // $('.video_topics').popover();
  // $("[rel='popover']").popover();
  // $("[rel='tooltip']").tooltip();

  $('.image_modal').click(function(e){
    var data_target = $(this).data('target');
    $(data_target).modal({
      remote: false
    });
    e.preventDefault();
  });


});
