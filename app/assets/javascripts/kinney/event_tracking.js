$(document).ready(function() {

  Kinney.pause = function(){
    // pause to allow google script to run before going to new page
    var date = new Date();
    var curDate = null;
    do {
      curDate = new Date();
    } while(curDate-date < 300);
  }
  
  Kinney.this_or_parent_id = function(that){
    if (that.get(0).id.length > 0){
      var identifier = that.get(0).id;
    } else {
      var identifier = that.parents('[id]:first').get(0).id;
    }
    return identifier;
  }

  Kinney.video_identifier = function(){
    return $('video').get(0).id;
  }
  
  Kinney.console_log_error = function(err, values){   
    console.log(err);
    console.log(values);   
  }
  
  // track all the links on the page
  $('a').click(function(){
    // tell analytics to save event
    try {
      var body_identifier = $('body').get(0).id;
      var identifier = Kinney.this_or_parent_id($(this));  
      // for facets we make the action the facet heading
      var text = $(this).text();
      if (/\S/.test(text)) {
        // string is not empty and not just whitespace
        var label = text;
      } else {
        var label = $(this).find('img:first').attr('alt');
      }
      _gaq.push(['_trackEvent', body_identifier, identifier, label.replace(/\s+/g, " ")]);
      Kinney.track();
    } catch (err) {
      Kinney.console_log_error(err, [body_identifier, identifier, label]);
    }
    Kinney.pause();   
  }); 
  
  // track non-link, non-event video elements
  $('.mejs-fullscreen-button').click(function(){
    _gaq.push(['_trackEvent', 'Videos', 'Full Screen', Kinney.video_identifier()]);
  });
  $('.mejs-volume-button').click(function(){
    _gaq.push(['_trackEvent', 'Videos', 'Volume', Kinney.video_identifier()]);
  });
  $('.mejs-captions-button').click(function(){
    _gaq.push(['_trackEvent', 'Videos', 'Captions', Kinney.video_identifier()]);
  });
  $('.mejs-time-rail').click(function(){
    _gaq.push(['_trackEvent', 'Videos', 'Time Rail', Kinney.video_identifier()]);
  });

  
  
});
