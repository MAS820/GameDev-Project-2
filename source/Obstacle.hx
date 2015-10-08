package;

import flixel.FlxSprite;
import flixel.FlxG;


class Obstacle extends FlxSprite {
	public var speed: Float;
	
	public function new(sprite: String) 
	{
		super(FlxG.width, Math.random() * (FlxG.height - 450) + 450);
		loadGraphic(sprite, false);
		this.y -= this.frameHeight / 2;
		speed = 300;
		velocity.x = -speed;
	}
}