package;

import flixel.FlxSubState;
import haxe.Timer;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

/**
 * ...
 * @author 
 */
class TransitionState extends FlxSubState
{

	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		Timer.delay(moveToTown, 2000);
		
		var gameOverText = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2, 500, "We made it to town.", 24);
		gameOverText.alignment = "center";
		add(gameOverText);
	}
	
	private function moveToTown() {
		FlxG.switchState(new TownState());
	}
	
}