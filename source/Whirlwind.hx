package;

import flixel.FlxG;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class Whirlwind extends Obstacle
{
	public var SpeedY:Float;
	
	public function new():Void 
	{
		super("assets/images/whirlwind.png");
		SpeedY = 100;
		velocity.y = -SpeedY;
		velocity.x = -400;
		setGraphicSize(0, 100);
		updateHitbox();
		
		// make a reasonable collision hitbox
		width /= 2;
		offset.x += width / 2;
		
		FlxRandom.resetGlobalSeed();
		
		x = FlxG.width;
		y = FlxRandom.floatRanged(FlxG.height - 490 - height / 2, FlxG.height - height);
	}
	
	override public function update():Void
	{
		super.update();
		if (this.y > FlxG.height) {
			velocity.y = -SpeedY;
		}
		else if (this.y < (FlxG.height - 450)) {
			velocity.y = SpeedY;
		}
	}
}