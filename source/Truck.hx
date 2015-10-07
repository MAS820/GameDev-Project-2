package source;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Truck extends FlxSprite
{
	public var speed: Float;
	public var alcoholLevel: Float;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		makeGraphic(60, 30, FlxColor.RED);
		drag.x = drag.y = 900;
		speed = 200;
		
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
		
		if (FlxG.keys.justPressed.LBRACKET) {
			alcoholLevel -= 0.1;
			if (alcoholLevel < 0.1)
				alcoholLevel = 0.1;
		}
		else if (FlxG.keys.justPressed.RBRACKET) {
			alcoholLevel += 0.1;
			if (alcoholLevel > 0.9)
				alcoholLevel = 0.9;
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
		
		drag.y = alcoholLevel * 1800;
	}
	
	override public function update(): Void {
		movement();
		super.update();
	}
	
}