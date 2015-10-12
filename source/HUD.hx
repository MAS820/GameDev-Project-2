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
	private var _sprBack:FlxSprite;
	private var _sprHealth: FlxSprite;
	private var _txtHealth: FlxText;
	private var _player: Truck;

	public function new(player) 
	{
		super();
		
		_player = player;
		
		_sprBack = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		_sprBack.drawRect(0, 98, FlxG.width, 2, FlxColor.WHITE);
		
		_txtHealth = new FlxText(32, 2, 0, "3 / 3", 32);
		_sprHealth = new FlxSprite(100, _txtHealth.y + (_txtHealth.height / 2) - 4, "assets/images/car.png");
		
		_txtAlcohol = new FlxText(FlxG.width - 210, 30, 200, "Alcohol: " + _player.alcoholLevel, 14);
		_txtAlcohol.alignment = "right";
		_sprAlcohol = new FlxBar(FlxG.width - 110, 10);
		
		add(_sprBack);
		add(_sprHealth);
		add(_txtHealth);
		add(_txtAlcohol);
		add(_sprAlcohol);
		
		forEach(function(spr:FlxSprite) {
             spr.scrollFactor.set();
		});
	}
	
	
	public function updateHUD(health: Int, alcoholLevel: Float): Void {
		_txtHealth.text = Std.string(health) + " / 3";
		_sprAlcohol.currentValue = alcoholLevel * 100;
		_txtAlcohol.text = "Alcohol: " + Std.string(_player.alcoholLevel).substr(0, 4);
		
		forEach(function(spr: FlxSprite) {
			spr.update();
		});
	}
}