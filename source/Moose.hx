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
	}
	
	public function charge() {
		velocity.x = -maxSpeed;
	}
}