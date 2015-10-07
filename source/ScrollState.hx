package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import source.Truck;

/**
 * ...
 * @author ...
 */
class ScrollState extends FlxState
{
	public var backdrop:FlxBackdrop;
	public var road:FlxBackdrop;
	private var _player: Truck;
	private var text: FlxText;

	override public function create():Void
	{
		super.create();
		
		backdrop = new FlxBackdrop("assets/images/backdrop.png");
		backdrop.velocity.x = -200;
		add(backdrop);
		
		road = new FlxBackdrop("assets/images/road.png", 0, 0, true, false);
		road.y = 448;
		road.velocity.x = -750;
		add(road);
		
		super.create();
		_player = new Truck(100, 450);
		_player.speed = 250;
		add(_player);
		
		text = new FlxText(10, 10, 200, "Alcohol: " + _player.alcoholLevel, 14);
		add(text);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void
	{
		super.update();
		text.text = "Alcohol: " + _player.alcoholLevel;
		FlxSpriteUtil.bound(_player, 0, FlxG.width, 448, FlxG.height);
	}
	
}