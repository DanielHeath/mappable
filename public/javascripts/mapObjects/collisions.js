/*global MapObject _ jQuery*/
MapObject.prototype.overlapsWith = function (pos, object) {
/*
	Determine the left/top-most object.
	Then, determine whether that object is big enough to reach the other one.
*/
	var xObjs, xOverlap, yObjs, yOverlap;
	xObjs = _([pos, object]).sort(function (a, b) { 
		return a.xGrid - b.xGrid;
	});
	xOverlap = ((xObjs[0].xGrid + xObjs[0].sizeGrid) > xObjs[1].xGrid);
	yObjs = _([pos, object]).sort(function (a, b) { 
		return a.yGrid - b.yGrid;
	});
	yOverlap = ((yObjs[0].yGrid + yObjs[0].sizeGrid) > yObjs[1].yGrid);
	
	return xOverlap && yOverlap;
};

MapObject.prototype.getOverlapping = function (pos) {
	var self = this, overlapping = [];
	jQuery.each(MapObject.list, function (o) {
		if ((!(self === MapObject.list[o])) && self.overlapsWith(pos, MapObject.list[o])) {
			overlapping.push(MapObject.list[o]);
		}
	});
	return overlapping;
};

MapObject.prototype.doCollisions = function (oldPositions, newPositions) {
	var self = this, allowMovement = true, oldOverlap, newOverlap, whileOverlap, noLongerOverlap;
	
	oldOverlap = this.getOverlapping(oldPositions);
	newOverlap = this.getOverlapping(newPositions);
	
	whileOverlap = [];
	noLongerOverlap = [];
	if (oldOverlap.length > 0) {
		whileOverlap = _(newOverlap).intersect(oldOverlap);
		noLongerOverlap = _(oldOverlap).select(function (o) {
			return !_(newOverlap).include(o); 
		});
    newOverlap = _(newOverlap).select(function (o) {
			return !_(oldOverlap).include(o); 
		});
	}
	jQuery.each(newOverlap, function (o) {
		allowMovement = allowMovement && self.onObjectCollision(newOverlap[o]);
	});
	jQuery.each(whileOverlap, function (o) {
		allowMovement = allowMovement && self.onMoveWhileOverlappingObject(whileOverlap[o]);
	});
	jQuery.each(noLongerOverlap, function (o) {
		allowMovement = allowMovement && self.onLeaveObjectSpace(noLongerOverlap[o]);
	});
	
	return allowMovement;
};

MapObject.prototype.anyOverlap = function () {
	return this.getOverlapping(this);
};

MapObject.opacifyOverlapping = function () {
	jQuery.each(MapObject.list, function (o) {
		if (MapObject.list[o].anyOverlap()[0]) {
			MapObject.list[o].element.addClass("overlappingMapObject");
		} else {
			MapObject.list[o].element.removeClass("overlappingMapObject");
		}	
	});
};
