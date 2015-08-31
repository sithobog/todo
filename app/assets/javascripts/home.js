var ready;

ready = function(){
	$(window).resize(function(){
	  var footerHeight = $('footer').outerHeight();
	  var headerHeight = $('header').outerHeight();
	  var stickFooterPush = $('.push').height(footerHeight);
		$('.wrapper').css({'marginBottom':'-' + footerHeight + 'px'});
	});
	$(window).resize();
}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);
