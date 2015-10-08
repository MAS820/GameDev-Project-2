package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
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
	private var rockArr: Array<Rock>;
	private var mooseGroup: FlxTypedGroup<Moose>;
	private var rockGroup: FlxTypedGroup<Rock>;
	
	//testing perposes
	private var _testBTN : FlxButton;
	/////////////////////////////////

	override public function create():Void
	{
		super.create();
		
		// DEBUG MODE
		
		FlxG.debugger.drawDebug = true;
		
		// ensure our world (collision detection) is set properly
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		
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
		mooseGroup = new FlxTypedGroup<Moose>();
		rockArr = new Array<Rock>();
		rockGroup = new FlxTypedGroup<Rock>();
		
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
		addRocks();
		updateMoose();
		FlxG.collide(rockGroup, mooseGroup);
	}
	
	// spawn moose randomly, accounting for some spacing between them
	private function updateMoose() {
		var shouldSpawn:Bool = true;
		var itr: Iterator<Moose> = mooseArr.iterator();
		for (moose in itr) {
			moose.update();
			
			// check collisions with rocks
			var itr: Iterator<Rock> = rockArr.iterator();
			for (rock in itr) {
				FlxG.collide(rock, moose);
			}
			
			// check whether or not we should spawn/remove moose
			if (moose.x > FlxG.width / 3)
				shouldSpawn = false;
			else if (moose.x < -moose.width) {
				remove(moose);
				mooseArr.remove(moose);
				mooseGroup.remove(moose);
			}
			// make the moose charge if it sees the player
			if (Math.abs((moose.y + moose.height/2) - (_player.y)) < _player.height / 2
					&& moose.x > _player.x) {
				moose.charge();
			}
		}
		
		shouldSpawn = shouldSpawn && (Math.random() > 0.85);
		
		if (shouldSpawn && mooseArr.length < 2) {
			mooseArr.push(new Moose());
			add(mooseArr[mooseArr.length - 1]);
			mooseGroup.add(mooseArr[mooseArr.length - 1]);
		}
	}
	
	private function addRocks() {
		var shouldSpawn: Bool = true;
		var itr: Iterator<Rock> = rockArr.iterator();
		
		for (rock in itr) {
			if (rock.x > FlxG.width / 2)
				shouldSpawn = false;
			else if (rock.x < -rock.width) {
				remove(rock);
				rockArr.remove(rock);
				rockGroup.remove(rock);
			}
		}
		
		shouldSpawn = shouldSpawn && (Math.random() > 0.5);
		
		if (shouldSpawn && rockArr.length < 4) {
			rockArr.push(new Rock());
			add(rockArr[rockArr.length - 1]);
			rockGroup.add(rockArr[rockArr.length - 1]);
		}
	}
	
}