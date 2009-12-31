/*global MapObject jQuery window console */
MapObject.prototype.onSelected = function () {
	// Do nothing unless overridden.
	jQuery(".characterInfoPanel").hide();
	jQuery("#" + this.options.charInfoPanelID).show();
//	alert(Should really have an onDeselected)
	return true;
};

MapObject.prototype.beforeMove = function (newPositions) {
	// Do nothing unless overridden.
	return true;
};
	
MapObject.prototype.afterMove = function (oldPositions) {
	var self = this;
	jQuery.ajax({
		type: "post",
		url: "/moves",
		data: {
			'move[old_x]': oldPositions.xGrid,
			'move[old_y]': oldPositions.yGrid,
			'move[new_x]': self.xGrid,
			'move[new_y]': self.yGrid,
			'move[entity_id]': self.options.id
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			self.xGrid = oldPositions.xGrid;
			self.yGrid = oldPositions.yGrid;
			self.reDraw();
			MapObject.opacifyOverlapping();
		}
	});
};

MapObject.prototype.onOutOfBounds = function () {
	// Individual objects can have this function re-assigned.
	// Return true to allow an object to move out of bounds.
	return false;
};

MapObject.prototype.onMoveWhileOverlappingObject = function (collidedWith) {
	// Do nothing unless overridden.
	// Return false to stop movement within an overlapping object.
	return true;
};

MapObject.prototype.onLeaveObjectSpace = function (collidedWith) {
	// Do nothing unless overridden.
	// Return false to stop them leaving.
	return true;
};

MapObject.prototype.onObjectCollision = function (collidedWith) {
	// Do nothing unless overridden.
	// Return false to stop them entering the zone.
	if (collidedWith.options.deadzone) {
		return false;
	}
	return true;
};
