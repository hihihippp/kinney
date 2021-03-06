$(document).ready(function() {

  function checkForWebvtt(){
    var path = siskelPath($('body.admin_kinney_clips input#kinney_clip_filename').val());
    if (path){
      $('video').attr('poster', path + '.png');
      $('video').attr('src', path + '.webm');

      $.ajax({
        url: path + '.vtt',
        success: function(data) {
          $('#vtt textarea').val(data);
          $('#vtt_result').html('<div class="alert alert-success">WEBVTT Found. Fill out the other required fields and you can save.</div>');
          // $('body.admin_kinney_clips #kinney_clip_submit_action input').removeAttr('disabled');
        },
        error: function(data){
          $('#vtt textarea').val('NO WEBVTT FILE FOUND!!!');
          $('#vtt_result').html('<div class="alert alert-error">WEBVTT Not Found. You will not be able to save this clip without a WEBVTT file on the server.</div>');
          // $('body.admin_kinney_clips #kinney_clip_submit_action input').attr('disabled', 'disabled');
        }
      });

    }
  }


  if ($('body.admin_kinney_clips.edit,body.admin_kinney_clips.new').length > 0) {
    // WEBVTT must be present to submit form
    // FIXME: This may not be wanted in all circumstances so make it configurable whether this is on or not
    // $('body.admin_kinney_clips #kinney_clip_submit_action input').attr('disabled', 'disabled');
    $('#vtt_result').html('<div class="alert">Give focus to the filename. You will not be able to save until there is a WEBVTT file.</div>');
    // checkForWebvtt();
    $('body.admin_kinney_clips input#kinney_clip_filename').bind('keyup change paste focus', function(){
      setTimeout(function(){
        checkForWebvtt();
      }, 100);

    });
  }


  $('video').on('loadedmetadata', function(){
    var duration = Math.round($('video').get(0).duration);
    $('#kinney_clip_duration').val(duration);
  });


});