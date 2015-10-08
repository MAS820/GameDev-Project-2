package source;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Truck extends FlxSprite
{
	public var speed: Float;
	public var alcoholLevel: Float;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic("assets/images/car.png");
		drag.x = drag.y = 1500;
		speed = 200;
		
		acceleration.x = acceleration.y = 0;
		
		alcoholLevel = 0.5;
		
	}
	
	private function movement(): Void {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		if (FlxG.keys.pressed.LBRACKET) {
			alcoholLevel -= 0.05;
			if (alcoholLevel < 0.01)
				alcoholLevel = 0.01;
		}
		else if (FlxG.keys.pressed.RBRACKET) {
			alcoholLevel += 0.05;
			if (alcoholLevel > 0.99)
				alcoholLevel = 0.99;
		}
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if (_up || _down) {
			if (_up) {
				velocity.y = -speed;
			}
			else if (_down) {
				velocity.y = speed;
			}
		}
		
		drag.y = 1500 * (1 - alcoholLevel);
	}
	
	public function damage(ob1: FlxObject, ob2: FlxObject) : Void {
		// Damage the player vehicle
	}
	
	override public function update(): Void {
		movement();
		super.update();
	}
	
}