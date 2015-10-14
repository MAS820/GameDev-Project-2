package;

import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Moose extends Obstacle
{
	public var defaultSpeed: Float;
	public var maxSpeed: Float;
	
	public function new() 
	{
		super("assets/images/moose.png");
		loadGraphic("assets/images/moose.png", true, 575, 503);
		setGraphicSize(150, 0);
		updateHitbox();
		
		maxSpeed = 700;
		defaultSpeed = 500;
		
		x = FlxG.width;
		y = Math.random() * 490 + (FlxG.height - 490) - height;
		if (y < (FlxG.height - 490 - height / 2)) {
			y = FlxG.height - 490 - height / 2;
		}
		velocity.x = -defaultSpeed;
		
		height = height * 2 / 3;
		offset.y += height / 2;
		width = width * 3 / 4;
		offset.x += width / 3;
		
	}
	
	public function charge(): Void {
		animation.frameIndex = 1;
		velocity.x = -maxSpeed;
	}
}