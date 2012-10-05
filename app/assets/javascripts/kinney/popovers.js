$(document).ready(function() {
  //Popovers
  Kinney.twitter_bootstrap_popover_placement = function(){
    var width = window.innerWidth;
    if ($('#kinney_people_show').length > 0){
      return 'bottom';
    }
    if (width<900) return 'bottom';
    // FIXME: is there a better way to get the parent of the element which triggered the popover?
    if ($($(this)[0].$element[0]).parent().hasClass('odd') || $($(this)[0].$element[0]).parent().hasClass('left')) {
      return 'right';
    }
    return 'left';
  }

  // This is a test that ought to work in testing for touch devices
  Kinney.is_touch_device = function() {
    return !!('ontouchstart' in window);
  }

  // We only want popovers to show up on the desktop. These are currently just
  // informational, so we do not need to show them on touch devices.
  if ( !Kinney.is_touch_device() ){
    $('[rel="popover"]').popover({
      trigger: 'hover',
      placement: Kinney.twitter_bootstrap_popover_placement
    });

    $('[rel="tooltip"]').tooltip();
  } 


  // Modals
  $('.image_modal_trigger').click(function(e){
    var data_target = $(this).data('target');
    $(data_target).modal({
      remote: false
    });
    e.preventDefault();
  });


});
