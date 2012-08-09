$(function() {
  var num_of_rows_to_show = '3';

  $('#transcript_table')
  .find('tr:gt(' + num_of_rows_to_show + ')').hide().end()
  .after('<div id="more_transcript"><a id="more_transcript_button" class="btn"><i class="icon-arrow-down"></i> Show All of the Transcript</a><a id="hide_transcript_button" class="btn" style="display:none;"><i class="icon-arrow-up"></i> Hide most of the transcript</a></div>');

  $('#transcript_table')
  .find('tr:nth-child(' + num_of_rows_to_show + ')').addClass('last');

  var toggles = function(){
    $('table')
    .find('tr:gt(' + num_of_rows_to_show + ')').toggle();
    $('#more_transcript a').toggle();
    $('table tr:nth-child(' + num_of_rows_to_show + ')').toggleClass('last');
    return false;
  }


  $("#more_transcript_button").click(function() {
    toggles();
  });
  $("#hide_transcript_button").click(function() {
    toggles();
  });

});