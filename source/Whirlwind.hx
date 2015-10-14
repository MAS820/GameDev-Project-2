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
		setGraphicSize(0, 100);
		updateHitbox();
		
		// make a reasonable collision hitbox
		width /= 2;
		offset.x += width / 2;
		
		SpeedY = 300;
		velocity.y = -SpeedY;
		
		x = FlxG.width;
		y = Math.random() * 490 + (FlxG.height - 490) - height;
		if (y < (FlxG.height - 490 - height / 2)) {
			y = FlxG.height - 490 - height / 2;
		}
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