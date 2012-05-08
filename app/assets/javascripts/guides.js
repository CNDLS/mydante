$(document).ready(function() {
	$("#viewer").fancybox({
		autoSize: false,
		width: 480,
		height: 324,
	});
});

function show_media(filename){
	if (window.api == undefined){ alert("Flowplayer failed to load."); return; }
	
	$f("player", {
    src: "../assets/flowplayer-3.2.10.swf",
    wmode: "transparent"
    }, {
    // fullscreen button not needed here
    plugins: {
        controls: {
          fullscreen: true,
          height: 24,
          autoHide: false
        }
    },
		clip: {'url':'../assets/' + filename + '.flv', 'autoplay':true}
  });
	
	$("#viewer").click();
}