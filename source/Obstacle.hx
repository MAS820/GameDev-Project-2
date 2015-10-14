package;

import flixel.FlxSprite;
import flixel.FlxG;


class Obstacle extends FlxSprite {
	public var speed: Float;
	
	public function new(sprite: String) 
	{
		super(0, 0);
		loadGraphic(sprite, false);
		speed = 300;
		velocity.x = -speed;
	}
}