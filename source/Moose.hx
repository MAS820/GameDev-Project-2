package;

import flixel.FlxG;
import flixel.util.FlxRandom;

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
		
		FlxRandom.resetGlobalSeed();
		
		x = FlxG.width;
		y = FlxRandom.floatRanged(FlxG.height - 490 - height / 2, FlxG.height - height);

		maxSpeed = 700;
		defaultSpeed = 500;
		
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