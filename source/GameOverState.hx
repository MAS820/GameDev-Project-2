package;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * ...
 * @author 
 */
class GameOverState extends FlxSubState
{

	override public function create() 
	{
		super.create();
		var gameOverText = new FlxText(FlxG.width / 2 - 150, FlxG.height / 2, 300, "Game over...", 24);
		gameOverText.alignment = "center";
		add(gameOverText);
		
		var resetButton = new FlxButton(FlxG.width / 2, FlxG.height / 2 + 30, "Start over", startOver);
		resetButton.x -= resetButton.width / 2;
		add(resetButton);
	}
	
	function startOver():Void
	{
		FlxG.switchState(new MenuState());
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