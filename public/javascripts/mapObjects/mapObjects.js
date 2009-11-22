/* 

Need to handle document resizing (do a resize after!)	
Need to support multi-collisions (currently only 1 collision supported)

*/

function MapObject(name, map, image, options) {
	var self = this;
	this.name = name;
	this.options = options;
	this.map = map;

	// Setup image tag
	this.element = $("<img/>").attr({src: image, className: "MapObject"});
	this.element.click(function() {
		self.makeSelected();
	});
	
	// Set position/size info
	this.xGrid = options.left - 1;
  this.yGrid = options.top - 1;
	this.sizeGrid = options.size || 1;
	this.reDraw(true);

	// Add to document
	$("body").append(this.element);
	
	// Keep in a class list so we can find all the map objects
	if (!MapObject.list) {
		MapObject.list = [];
	} 
	MapObject.list.push(this);
		
	// Something needs to be selected, so select ourselves if theres no selection at the moment.
	if (!MapObject.last_selected) {
		this.makeSelected();
	}
	
};

MapObject.prototype.makeSelected = function(){
	if (!this.options.locked){
		MapObject.last_selected = this;
		$(".selectedMapObject").removeClass("selectedMapObject");
		this.element.addClass("selectedMapObject");
		return true;
	}
	else return false;
}

MapObject.prototype._reDraw = function(attrs, jump) {
	if (jump) {
		this.element.css(attrs);
	}
	else {
		this.element.animate(attrs, 100);
	}
}

MapObject.prototype.reDraw = function(jump) {
	this._reDraw({
			left: this.map.gridLeft(this.xGrid), 
			top: this.map.gridTop(this.yGrid),
			width: this.map.squareW * this.sizeGrid,
			height: this.map.squareH * this.sizeGrid
		}, jump);
}

MapObject.prototype.move = function(x, y){
	var self = this;

	// Save the positions in case something stops us moving.
	var oldPositions = {
		xGrid: this.xGrid,
		yGrid: this.yGrid,
		sizeGrid: this.sizeGrid
	};
	var newPositions = {
		xGrid: this.xGrid + (x || 0),
		yGrid: this.yGrid + (y || 0),
		sizeGrid: this.sizeGrid
	};
	var stopMovement = false;

	if (this.outOfBounds(newPositions)){ 
		stopMovement = !this.onOutOfBounds();
	}

	if (stopMovement) return false;
			
	// Now we raise any collision events. 
	// If you move around inside the space of a large object, 
	// you get a different event to the event you get when you enter the borders.
	stopMovement = !this.doCollisions(oldPositions, newPositions);
	
	if (stopMovement) return false;
	
	// Trigger beforeMove event
	stopMovement = !this.beforeMove(newPositions);
	
	if (stopMovement) return false;
	
	this.opacifyOverlapping(oldPositions, newPositions);

	this.xGrid = newPositions.xGrid;
	this.yGrid = newPositions.yGrid;
	
	this.reDraw();
	this.afterMove();
}

MapObject.prototype.outOfBounds = function(position){
	if (position.xGrid < 0) 							return true;
	if (position.xGrid >= this.map.gridW) return true;
	if (position.yGrid < 0) 							return true;
	if (position.yGrid >= this.map.gridH) return true;
	return false;
}

MapObject.selectNext = function(){
	var current = MapObject.list.indexOf(MapObject.last_selected);
	var i = 1;
	while (	(i < 1000) && 
					(!MapObject.list[((current + i) % MapObject.list.length)].makeSelected())) {
				
		i++
	}
}

$(function() {
	// Onload, sets up a bunch of stuff.
	$("body").keydown(function(e) {
		var dx = {
			37: -1,
			39: 1
		}
		var dy = {
			38: -1,
			40: 1
		}
		if (dx[e.which] || dy[e.which]) {
			MapObject.last_selected.move(dx[e.which], dy[e.which]);			
			MapObject.last_selected.reDraw();
			e.preventDefault();
//			MapObject.last_selected.element.animate(actions[e.which], "fast")
//			$.ajax({url: "I think URL is the name to use, check that."})
		};
		if (e.which == 9) {
			MapObject.selectNext();
			e.preventDefault();			
		};
	});
	
	window.onresize = function() {
		jQuery.each(MapObject.list, function(o) { MapObject.list[o].reDraw(true) });
	};
	
});


