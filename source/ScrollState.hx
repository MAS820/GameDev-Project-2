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
	private var mooseArr: Array<Moose>;
	
	//testing perposes
	private var _testBTN : FlxButton;
	/////////////////////////////////

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
		
		_player = new Truck(100, 450);
		_player.speed = 250;
		add(_player);
		
		mooseArr = new Array<Moose>();
		
		text = new FlxText(FlxG.width - 210, 10, 200, "Alcohol: " + _player.alcoholLevel, 14);
		add(text);
		
		//testing perposes
		_testBTN = new FlxButton(0,0,"Change", clickToChange);
		add(_testBTN);
		////////////////////////////////////////////////////////
	}
	
	//testing perposes
	private function clickToChange():Void 
	{
		FlxG.switchState(new TownState());
		super.create();
	}
	///////////////////////////////////////
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void
	{
		super.update();
		text.text = "Alcohol: " + _player.alcoholLevel;
		FlxSpriteUtil.bound(_player, 0, FlxG.width, 448, FlxG.height);
		updateMoose();
	}
	
	// spawn moose randomly, accounting for some spacing between them
	private function updateMoose() {
		var shouldSpawn:Bool = true;
		var itr: Iterator<Moose> = mooseArr.iterator();
		for (moose in itr) {
			moose.update();
			// check whether or not we should spawn/remove moose
			if (moose.x > FlxG.width / 2)
				shouldSpawn = false;
			else if (moose.x < -moose.width) {
				remove(moose);
				mooseArr.remove(moose);
			}
			// make the moose charge if it sees the player
			if (Math.abs((moose.y + moose.height/2) - (_player.y)) < _player.height / 2
					&& moose.x > _player.x) {
				moose.charge();
			}
		}
		
		if (shouldSpawn && mooseArr.length < 2) {
			mooseArr.push(new Moose());
			add(mooseArr[mooseArr.length - 1]);
		}
	}
	
}