MapObject.prototype.beforeMove = function(newPositions){
	// Do nothing unless overridden.
	return true;
}

MapObject.prototype.afterMove = function(){
	// Do nothing unless overridden.
	// Return value is ignored.
}

MapObject.prototype.onOutOfBounds = function(){
	// Individual objects can have this function re-assigned.
	// Return true to allow an object to move out of bounds.
	return false
}

MapObject.prototype.onMoveWhileOverlappingObject = function(collidedWith){
	// Do nothing unless overridden.
	if (window.mapObjectDebug) console.log(this.name + " moved while overlapping with something. It looks like " + collidedWith.name);
	// Return false to stop movement within an overlapping object.
	return true;
};

MapObject.prototype.onLeaveObjectSpace = function(collidedWith){
	// Do nothing unless overridden.
	// Return false to stop them leaving.
	if (window.mapObjectDebug) console.log(this.name + " left the space of " + collidedWith.name);
	return true;
};

MapObject.prototype.onObjectCollision = function(collidedWith){
	// Do nothing unless overridden.
	// Return false to stop them entering the zone.
	if (collidedWith.options.deadzone){
		return false;
	}
	if (window.mapObjectDebug) console.log(this.name + " collided with something. It looks like " + collidedWith.name);
	return true;
};
