package;

import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Moose extends FlxSprite
{
	public var defaultSpeed: Float;
	public var maxSpeed: Float;
	private var charging: Bool;
	
	public function new() 
	{
		super(FlxG.width, Math.random() * (FlxG.height - 450) + 450);
		loadGraphic("assets/images/moose.png", false);
		this.y -= this.height;
		maxSpeed = 300;
		defaultSpeed = 150;
		charging = false;
		
	}
	
	public function charge() {
		charging = true;
	}
	
	override public function update() {
		if (charging) {
			velocity.x = -maxSpeed;
		}
		else {
			velocity.x = -defaultSpeed;
		}
		super.update();
	}
}