package;

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
		SpeedY = 300;
	}
	
	override public function update():Void
	{
		super.update();
		//if (position is at max) {
			//velocity.y = SpeedY;
		//}
		//else if (position is at min) {
			//velocity.y = SpeedY;
		//}
	}
}