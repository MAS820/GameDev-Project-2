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
	private var party : PartyClass;
	private var timer: Timer;
	private var text: FlxText;

	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		timer = Timer.delay(moveToTown, 2000);
		
		text = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2, 500, "We made it to town.", 24);
		text.alignment = "center";
		add(text);
	}
	
	public function init(p: PartyClass) {
		party = p;
		if (party._level > 2) {
			timer.stop();
			text.text = "We're gonna make it!";
			timer = Timer.delay(moveToWinScreen, 2000);
		}
		
	}
	
	private function moveToTown() {
		var nextTown = new TownState();
		nextTown.init(party);
		FlxG.switchState(nextTown);
	}
	
	private function moveToWinScreen() {
		FlxG.switchState(new WinState());
	}
}