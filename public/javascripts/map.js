function Map(image, options) {
	this.options = options;
	this.element = $("<img/>").attr({src: image, className: "map"});
	$("body").prepend(this.element);

	this.xOffset = options.xOffset || 0;
	this.yOffset = options.yOffset || 0;
	this.gridW = options.gridX;
	this.gridH = options.gridY;
	this.squareW = this.element.width() / this.gridW;
	this.squareH = this.element.height() / this.gridH;
}

Map.prototype.gridLeft = function(x){
	return this.element.offset().left + (x * this.squareW) + this.xOffset
}
Map.prototype.gridTop = function(y){
	return this.element.offset().top + (y * this.squareH) + this.yOffset
}