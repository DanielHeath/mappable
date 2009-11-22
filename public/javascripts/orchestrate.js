
$(function() {
	var map = new Map("images/map.jpg", {gridX: 53, gridY:66, xOffset:0, yOffset:-2});
window.mapObjectDebug = true;
	new MapObject("Impassable", map, "images/blank.png", {left:6,top:4,size:1,locked:true,deadzone:true});
	new MapObject("Guy on a Camel", map, "images/camelmerc.png", {left:6,top:3,size:1});
	new MapObject("Sandworm", map, "images/dustdigger.png", {left:3,top:2,size:2});
});
