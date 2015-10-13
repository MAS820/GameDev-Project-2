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
	
	private var _level: Int;
	private var party : PartyClass;

	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		Timer.delay(moveToTown, 2000);
		
		var gameOverText = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2, 500, "We made it to town.", 24);
		gameOverText.alignment = "center";
		add(gameOverText);
	}
	
	public function init(level: Int, p: PartyClass) {
		_level = level;
		party = p;
	}
	
	private function moveToTown() {
		var nextTown = new TownState();
		nextTown.init(_level, party);
		FlxG.switchState(nextTown);
	}
	
}