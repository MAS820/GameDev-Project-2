package source;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Timer;

class Truck extends FlxSprite
{
	public var speed: Float;
	public var alcoholLevel: Float;
	public var livesLeft: Int;
	private var isInvincible: Bool;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic("assets/images/car.png");
		drag.x = drag.y = 1000;
		speed = 200;
		
		acceleration.x = acceleration.y = 0;
		
		alcoholLevel = 0.5;
		
		isInvincible = true;
		Timer.delay(endInvincibility, 750);
		
		livesLeft = 3;
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
			if (alcoholLevel < 0)
				alcoholLevel = 0;
		}
		else if (FlxG.keys.pressed.RBRACKET) {
			alcoholLevel += 0.05;
			if (alcoholLevel > 1)
				alcoholLevel = 1;
		}
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if (_up || _down) {
			if (_up) {
				Timer.delay(velUp, Std.int(300 * alcoholLevel));
			}
			else if (_down) {
				Timer.delay(velDown, Std.int(300 * alcoholLevel));
			}
		}
	}
	
	private function velUp() {
		velocity.y = -speed;
	}
	
	private function velDown() {
		velocity.y = speed;
	}
	
	public function damage(ob1: FlxObject, ob2: FlxObject) : Void {
		if (!isInvincible) {
			// temporarily grant invincibility
			isInvincible = true;
			flashInvincibility();
			Timer.delay(endInvincibility, 1500);
			livesLeft--;
			// TODO: game over
		}
	}
	
	private function flashInvincibility() {
		if (isInvincible) {
			Timer.delay(flashInvincibility, 100);
			if (this.alpha == 0) {
				this.alpha = 1;
			}
			else {
				this.alpha = 0;
			}
		}
	}
	
	private function endInvincibility() {
		isInvincible = false;
		this.alpha = 1;
	}
	
	override public function update(): Void {
		movement();
		super.update();
	}
	
}