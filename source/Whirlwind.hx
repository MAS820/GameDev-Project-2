package;

import flixel.FlxG;

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