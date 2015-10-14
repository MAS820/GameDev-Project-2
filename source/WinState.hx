package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author 
 */
class WinState extends FlxState
{

	override public function create(): Void
	{
		super.create();
		var bg = new FlxSprite(0, 0, "assets/images/Win_scene.png");
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.screenCenter();
		add(bg);
		
		var text = new FlxText(FlxG.width / 2 - 250, FlxG.height / 6, 500, "You win!", 64);
		text.alignment = "center";
		text.color = FlxColor.BLACK;
		add(text);
		
		var resetButton = new FlxButton(FlxG.width / 2, FlxG.height / 6 + 72, "Start over", startOver);
		resetButton.x -= resetButton.width / 2;
		add(resetButton);
	}
	
	function startOver():Void
	{
		FlxG.switchState(new MenuState());
	}
}