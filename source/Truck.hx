package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Timer;

class Truck extends FlxSprite
{
	public var speed: Float;
	public var timeLeft: Int;
	private var _party: PartyClass;
	public var isInvincible: Bool;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic("assets/images/truck.png");
		setGraphicSize(200, 0);
		updateHitbox();
		
		// now adjust the hitbox for reasonable collisions
		height /= 2;
		offset.y += height;
		
		// change speed variables
		drag.x = drag.y = 1000;
		speed = 200;
		
		acceleration.x = acceleration.y = 0;
		
		isInvincible = true;
		Timer.delay(endInvincibility, 750);
		timeLeft = 59;
		Timer.delay(updateTimer, 1000);
	}
	
	public function init(p: PartyClass): Void {
		_party = p;
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
			_party._alcoholLevel -= 5;
			if (_party._alcoholLevel < 0)
				_party._alcoholLevel = 0;
		}
		else if (FlxG.keys.pressed.RBRACKET) {
			_party._alcoholLevel += 5;
			if (_party._alcoholLevel > 100)
				_party._alcoholLevel = 100;
		}
		
		// skip level key
		if (FlxG.keys.justPressed.N) {
			timeLeft = 3;
		}
		
		if (FlxG.keys.justPressed.R) {
			_party._carHealth = 100;
		}
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if (_up || _down) {
			if (_up) {
				Timer.delay(velUp, Math.round(3 * _party._alcoholLevel));
			}
			else if (_down) {
				Timer.delay(velDown, Math.round(3 * _party._alcoholLevel));
			}
		}
	}
	
	private function updateTimer() {
		timeLeft--;
		if (timeLeft < 0)
			timeLeft = 0;
		Timer.delay(updateTimer, 1000);
	}
	
	private function velUp() {
		velocity.y = -speed;
	}
	
	private function velDown() {
		velocity.y = speed;
	}
	
	public function takeDamage() : Void {
		if (!isInvincible) {
			// temporarily grant invincibility
			isInvincible = true;
			flashInvincibility();
			Timer.delay(endInvincibility, 1500);
			
			_party._carHealth -= Math.round(Math.random() * 10 + 20);
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