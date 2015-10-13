package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import Truck;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
	
	private var _sprAlcohol: FlxBar;
	private var _txtAlcohol: FlxText;
	private var _sprBack: FlxSprite;
	private var _sprHealth: FlxBar;
	private var _txtHealth: FlxText;
	private var _txtTimer: FlxText;
	private var _player: Truck;

	public function new(player) 
	{
		super();
		
		_player = player;
		
		_sprBack = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		_sprBack.drawRect(0, 98, FlxG.width, 2, FlxColor.WHITE);
		
		_sprHealth = new FlxBar(10, 10);
		_txtHealth = new FlxText(10, 30, 0, "Damage: ", 14);
		
		_sprAlcohol = new FlxBar(FlxG.width - 110, 10);
		_txtAlcohol = new FlxText(FlxG.width - 160, 30, 160, "Alcohol: ", 14);
		_txtAlcohol.alignment = "right";
		
		_txtTimer = new FlxText(FlxG.width / 2 - 75, 5, 150, "1:00", 48);
		_txtTimer.alignment = "center";
		
		add(_sprBack);
		add(_sprHealth);
		add(_txtHealth);
		add(_txtAlcohol);
		add(_sprAlcohol);
		add(_txtTimer);
		
		forEach(function(spr:FlxSprite) {
             spr.scrollFactor.set();
		});
	}
	
	
	public function updateHUD(health: Float, alcoholLevel: Float): Void {
		_txtHealth.text = "Damage: " + Std.string(Math.round(health)) + "%";
		_sprHealth.currentValue = health;
		_sprAlcohol.currentValue = alcoholLevel;
		_txtAlcohol.text = "Alcohol: " + Std.string(Math.round(alcoholLevel)) + "%";
		if (_player.timeLeft < 10) {
			_txtTimer.text = "0:0" + Std.string(_player.timeLeft);
		} else {
			_txtTimer.text = "0:" + Std.string(_player.timeLeft);
		}
		
		forEach(function(spr: FlxSprite) {
			spr.update();
		});
	}
}