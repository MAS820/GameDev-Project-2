package;

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
		maxSpeed = 300;
		defaultSpeed = 150;
		velocity.x = -defaultSpeed;
		height = height * 2 / 3;
		offset.y += height / 2;
		width = width * 3 / 4;
		offset.x += width / 3;
	}
	
	public function charge(): Void {
		velocity.x = -maxSpeed;
	}
}