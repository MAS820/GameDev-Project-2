package;

import flixel.FlxSprite;
import flixel.FlxG;


class Obstacle extends FlxSprite {
	public var speed: Float;
	
	public function new(sprite: String) 
	{
		super(0, 0);
		loadGraphic(sprite, false);
		this.y -= this.frameHeight / 2;
		speed = 500;
		velocity.x = -speed;
	}
}