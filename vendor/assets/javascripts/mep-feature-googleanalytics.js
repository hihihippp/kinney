/*
* Google Analytics Plugin
* Requires
*
*/

(function($) {

$.extend(mejs.MepDefaults, {
	googleAnalyticsTitle: '',
	googleAnalyticsCategory: 'Videos',
	googleAnalyticsEventPlay: 'Play',
	googleAnalyticsEventPause: 'Pause',
	googleAnalyticsEventEnded: 'Ended',
	googleAnalyticsEventTime: 'Time'
});


$.extend(MediaElementPlayer.prototype, {
	buildgoogleanalytics: function(player, controls, layers, media) {
			
		media.addEventListener('play', function() {
			if (typeof _gaq != 'undefined') {
				_gaq.push(['_trackEvent', 
					player.options.googleAnalyticsCategory, 
					player.options.googleAnalyticsEventPlay, 
					player.media.currentSrc,
					player.media.currentTime
				]);
			}
		}, false);
		
		media.addEventListener('pause', function() {
			if (typeof _gaq != 'undefined') {
				_gaq.push(['_trackEvent', 
					player.options.googleAnalyticsCategory, 
					player.options.googleAnalyticsEventPause, 
					player.media.currentSrc,
					player.media.currentTime
				]);
			}
			Kinney.track();
		}, false);	
		
		media.addEventListener('ended', function() {
			if (typeof _gaq != 'undefined') {
				_gaq.push(['_trackEvent', 
					player.options.googleAnalyticsCategory, 
					player.options.googleAnalyticsEventEnded, 
					player.media.currentSrc,
					player.media.currentTime
				]);
			}
			Kinney.track();			
		}, false);
		
		
		media.addEventListener('timeupdate', function() {
			if ($('#kinney_clips_show video').length > 0) {
				// console.log(parseInt(player.media.currentTime));
				var second = parseInt(player.media.currentTime);
				Kinney.tracker_seconds.push(second);
				if (Kinney.tracker_seconds.length >= 20) {
					Kinney.track();
				}
			}

		}, true);
		
	}
});
	
})(mejs.$);

