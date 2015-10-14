package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author 
 */
class WinState extends FlxState
{

	public function new() 
	{
		super();
		var bg = new FlxSprite(0, 0, "assets/images/Win_scene.png");
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.screenCenter();
		add(bg);
		
		var text = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2, 500, "You win!", 48);
		text.alignment = "center";
		add(text);
		
		var resetButton = new FlxButton(FlxG.width / 2, FlxG.height / 2 + 30, "Start over", startOver);
		resetButton.x -= resetButton.width / 2;
		add(resetButton);
	}
	
	function startOver():Void
	{
		FlxG.switchState(new MenuState());
	}
}