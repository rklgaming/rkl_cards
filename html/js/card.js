var debugMode = false;
var resourceName, pokemoncard;

$(function() {
  window.addEventListener('message', function(event) {
    if (event.data.type === "openViewCard") {
      $('body').fadeIn(500);   
      resourceName = event.data.resourceName;
      pokemoncard = event.data.pokemoncard;

		var canvas = document.getElementById('canvas'),
		ctx = canvas.getContext('2d'),
		canvasWidth = canvas.width,
		canvasHeight= canvas.height,
		image = new Image(),

		imageSrc = 'img/' + pokemoncard + '.png';
		brush = new Image();
		image.src = imageSrc;

		image.onload = function() {
			ctx.drawImage(
			image,
			canvas.width / 100 - image.width / 100,
			canvas.height / 100 - image.height / 100
		);
		};
	 }else if (event.data.type === "openBoosterCard") {
     $('body').fadeIn(500);   
      resourceName = event.data.resourceName;
      pokemoncard = event.data.pokemoncard;

		var canvas = document.getElementById('canvas'),
		ctx = canvas.getContext('2d'),
		canvasWidth = canvas.width,
		canvasHeight= canvas.height,
		image = new Image(),

		imageSrc = 'img/' + pokemoncard + '.png';
		brush = new Image();
		image.src = imageSrc;

		image.onload = function() {
			ctx.drawImage(
			image,
			canvas.width / 100 - image.width / 100,
			canvas.height / 100 - image.height / 100
		);
		};
    } else if (event.data.type === "closeCard") {
      $('body').fadeOut(500);
    }
	
	
  });
});






$(document).on('keyup', function(data) {
  if (data.which == 27) {
    $.post('https://' + resourceName + '/closeViewCard', JSON.stringify({}));
    window.location.reload();
  }
})



/*

  using 
    - an animated gif of sparkles.
    - an animated gradient as a holo effect.
    - color-dodge mix blend mode
  
*/
var x;
var $cards = $(".card");
var $style = $(".hover");

$cards
  .on("mousemove touchmove", function(e) { 
    // normalise touch/mouse
    var pos = [e.offsetX,e.offsetY];
    e.preventDefault();
    if ( e.type === "touchmove" ) {
      pos = [ e.touches[0].clientX, e.touches[0].clientY ];
    }
    var $card = $(this);
    // math for mouse position
    var l = pos[0];
    var t = pos[1];
    var h = $card.height();
    var w = $card.width();
    var px = Math.abs(Math.floor(100 / w * l)-100);
    var py = Math.abs(Math.floor(100 / h * t)-100);
    var pa = (50-px)+(50-py);
    // math for gradient / background positions
    var lp = (50+(px - 50)/1.5);
    var tp = (50+(py - 50)/1.5);
    var px_spark = (50+(px - 50)/7);
    var py_spark = (50+(py - 50)/7);
    var p_opc = 20+(Math.abs(pa)*1.5);
    var ty = ((tp - 50)/2) * -1;
    var tx = ((lp - 50)/1.5) * .5;
    // css to apply for active card
    var grad_pos = `background-position: ${lp}% ${tp}%;`
    var sprk_pos = `background-position: ${px_spark}% ${py_spark}%;`
    var opc = `opacity: ${p_opc/100};`
    var tf = `transform: rotateX(${ty}deg) rotateY(${tx}deg)`
    // need to use a <style> tag for psuedo elements
    var style = `
      .card:hover:before { ${grad_pos} }  /* gradient */
      .card:hover:after { ${sprk_pos} ${opc} }   /* sparkles */ 
    `
    // set / apply css class and style
    $cards.removeClass("active");
    $card.removeClass("animated");
    $card.attr( "style", tf );
    $style.html(style);
    if ( e.type === "touchmove" ) {
      return false; 
    }
    clearTimeout(x);
  }).on("mouseout touchend touchcancel", function() {
    // remove css, apply custom animation on end
    var $card = $(this);
    $style.html("");
    $card.removeAttr("style");
    x = setTimeout(function() {
      $card.addClass("animated");
    },2500);
  });
  
  
  