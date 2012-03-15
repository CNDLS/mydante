$(document).ready(function() {
	$("ul.menubar > li.menu_btn > a")
		.focus(function(){ 
			var menu_btn_li = $(this).parent("li")
			menu_btn_li.addClass('focus');
			//var v = $("ul.menu > li.menu_item:first > a", menu_btn_li).focus();
		})
		.blur(function(){ $(this).parent("li").removeClass('focus'); });

	$('#page_bottom a.resizer').each(function(){
		var page = $('#page');
	  var curr_width = page.width();
		var natural_width = parseInt(page.css("width").sub("px", ""));
	  var percent_size = Math.min(1,(curr_width / natural_width));
	  $('#page').css({
	     "font-size": (percent_size * 100) + "%"
	  });
	});
});