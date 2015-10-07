package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.display.FlxBackdrop;

/**
 * ...
 * @author ...
 */
class ScrollState extends FlxState
{
	public var backdrop:FlxBackdrop;
	public var road:FlxBackdrop;

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
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void
	{
		super.update();
	}
	
}