MapObject.prototype.overlapsWith = function(pos, object) {
/*
	Determine the left/top-most object.
	Then, determine whether that object is big enough to reach the other one.
*/
	var xObjs = _([pos, object]).sort(function(a, b) { return a.xGrid - b.xGrid });
	var xOverlap = ((xObjs[0].xGrid + xObjs[0].sizeGrid) > xObjs[1].xGrid);
	var yObjs = _([pos, object]).sort(function(a, b) { return a.yGrid - b.yGrid });
	var yOverlap = ((yObjs[0].yGrid + yObjs[0].sizeGrid) > yObjs[1].yGrid);
	
	return xOverlap && yOverlap;
};

MapObject.prototype.getOverlapping = function(pos){
	var self = this;
	var overlapping = [];
	jQuery.each(MapObject.list, function(o) {
		if ((!(self == MapObject.list[o])) && self.overlapsWith(pos, MapObject.list[o])) {
			overlapping.push(MapObject.list[o]);
		}});
	return overlapping;
};

MapObject.prototype.doCollisions = function(oldPositions, newPositions){
	var self = this;
	var allowMovement = true;
	
	var oldOverlap = this.getOverlapping(oldPositions);
	var newOverlap = this.getOverlapping(newPositions);
	
	var whileOverlap = [];
	var noLongerOverlap = [];
	if (oldOverlap.length > 0) {
		whileOverlap = _(newOverlap).intersect(oldOverlap);
		noLongerOverlap = _(oldOverlap).select(function(o){ return !_(newOverlap).include(o); });
    newOverlap = _(newOverlap).select(function(o){ return !_(oldOverlap).include(o); });
	}
	jQuery.each(newOverlap, function(o) {allowMovement = allowMovement && self.onObjectCollision(newOverlap[o])});
	jQuery.each(whileOverlap, function(o) {allowMovement = allowMovement && self.onMoveWhileOverlappingObject(whileOverlap[o])});
	jQuery.each(noLongerOverlap, function(o) {allowMovement = allowMovement && self.onLeaveObjectSpace(noLongerOverlap[o])});
	
	if (allowMovement) {
		
	};
	
	return allowMovement;
};

MapObject.prototype.opacifyOverlapping = function(oldPositions, newPositions){
	var self = this;
	var oldOverlap = this.getOverlapping(oldPositions);
	var newOverlap = this.getOverlapping(newPositions);
		
	jQuery.each(oldOverlap, function(o) {
		oldOverlap[o].element.removeClass("overlappingMapObject");
		self.element.removeClass("overlappingMapObject");
	});
	jQuery.each(newOverlap, function(o) {
		newOverlap[o].element.addClass("overlappingMapObject");
		self.element.addClass("overlappingMapObject");
	});
}
