$(document).ready(function() {
  function siskelPath(filename){
    if (filename.match('-')){
      var url = 'http://siskel.lib.ncsu.edu/SLI';
      var name = filename.split('-')[0];
      return url + '/' + name + '/' + filename + '/' + filename;
    }    
  }

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
          $('body.admin_kinney_clips #kinney_clip_submit_action input').removeAttr('disabled');
        },
        error: function(data){
          $('#vtt textarea').val('NO WEBVTT FILE FOUND!!!');
          $('#vtt_result').html('<div class="alert alert-error">WEBVTT Not Found. You will not be able to save this clip without a WEBVTT file on the server.</div>');
          $('body.admin_kinney_clips #kinney_clip_submit_action input').attr('disabled', 'disabled');
        }
      });
      
    }
  }

  if ($('.admin_kinney_clips').length > 0) {
    // WEBVTT must be present to submit form
    $('body.admin_kinney_clips #kinney_clip_submit_action input').attr('disabled', 'disabled');  
    $('#vtt_result').html('<div class="alert">Give focus to the filename. You will not be able to save until there is a WEBVTT file.</div>');
    checkForWebvtt();
    $('body.admin_kinney_clips input#kinney_clip_filename').bind('keyup change paste focus', function(){
      checkForWebvtt();
    });
  }
  
  $('.admin_kinney_clips video').mediaelementplayer({
    success: function(mediaElement, domObject){
      mediaElement.addEventListener('loadedmetadata', function(){
        var duration = Math.round(mediaElement.duration);
        $('#kinney_clip_duration').val(duration);
      });
    }
  });
  
});