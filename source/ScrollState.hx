package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;
import Truck;

/**
 * ...
 * @author ...
 */
class ScrollState extends FlxState
{
	public var backdrop:FlxBackdrop;
	public var road:FlxBackdrop;
	private var scrollHud: HUD;
	
	private var _player: Truck;

	private var mooseArr: Array<Moose>;
	private var mooseGroup: FlxTypedGroup<Moose>;
	
	private var rockArr: Array<Rock>;
	private var rockGroup: FlxTypedGroup<Rock>;
	
	private var obstacleGroup: FlxGroup;
	
	private var collectibleArr:Array<Collectibles>;
	private var collectibles_layer:FlxTypedGroup<Collectibles>;
	
	private var _difficulty: Int;
	
	private var party : PartyClass;
	
	//FOR TESTING
	private var _testBTN : FlxButton;

	//------------------------------------
	//---------------CREATE---------------
	//------------------------------------
	override public function create():Void
	{
		super.create();
		
		// DEBUG MODE
		
		FlxG.debugger.drawDebug = true;
		
		// set the difficulty
		_difficulty = 0;
		
		// ensure our world (collision detection) is set properly
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		
		//--------------------------------------
		//---------------PARALLAX---------------
		//--------------------------------------
		backdrop = new FlxBackdrop("assets/images/backdrop.png");
		backdrop.velocity.x = -200;
		add(backdrop);
		
		road = new FlxBackdrop("assets/images/road.png", 0, 0, true, false);
		road.y = 448;
		road.velocity.x = -750;
		add(road);
		
		//-------------------------------------
		//---------------SPRITES---------------
		//-------------------------------------
		_player = new Truck(100, 450);
		_player.speed = 250;
		add(_player);
		
		mooseArr = new Array<Moose>();
		mooseGroup = new FlxTypedGroup<Moose>();
		
		rockArr = new Array<Rock>();
		rockGroup = new FlxTypedGroup<Rock>();
		
		obstacleGroup = new FlxGroup();
		
		collectibleArr = new Array<Collectibles>();
		collectibles_layer = new FlxTypedGroup<Collectibles>();
		
		//---------------------------------
		//---------------HUD---------------
		//---------------------------------		
		scrollHud = new HUD(_player);
		add(scrollHud);
		
		//FOR TESTING
		_testBTN = new FlxButton(0,0,"Change", clickToChange);
		add(_testBTN);
	}
	
	public function init(diff: Int, p: PartyClass) {
		trace("Difficulty " + diff);
		_difficulty = diff;
		party = p;
		
	}
	
	//-------------------------------------
	//---------------DESTROY---------------
	//-------------------------------------
	override public function destroy():Void
	{
		super.destroy();
	}
	
	//------------------------------------
	//---------------UPDATE---------------
	//------------------------------------
	override public function update():Void
	{
		super.update();
		FlxSpriteUtil.bound(_player, 0, FlxG.width, 448, FlxG.height);
		
		addRocks();
		
		// for levels past the first, add moose
		if (_difficulty > 0)
			updateMoose();
			
		updateCollectibles();
		
		FlxG.overlap(rockGroup, mooseGroup, blockMovement);
		// TODO: determine if the objects need to be destroyed / how we deal with collisions
		FlxG.overlap(_player, obstacleGroup, _player.damage);
		
		if (_player.livesLeft <= 0) {
			// make a game over
			openSubState(new GameOverState(FlxColor.BLACK));
		}
		else if (_player.timeLeft <= 0) {
			openSubState(new TransitionState(FlxColor.BLACK, _difficulty, party));
		}
		
		// update the HUD
		scrollHud.updateHUD(_player.livesLeft, _player.alcoholLevel);
	}
	
	//------------------------------------------------
	//---------------OBSTACLE FUNCTIONS---------------
	//------------------------------------------------
	private function updateMoose():Void
	{ // spawn moose randomly, accounting for some spacing between them
		var shouldSpawn:Bool = true;
		var itr: Iterator<Moose> = mooseArr.iterator();
		for (moose in itr) {
			moose.update();
			
			// check whether or not we should spawn/remove moose
			if (moose.x > FlxG.width / 3)
				shouldSpawn = false;
			else if (moose.x < -moose.width) {
				remove(moose);
				mooseArr.remove(moose);
				mooseGroup.remove(moose);
				obstacleGroup.remove(moose);
			}
			// make the moose charge if it sees the player
			if (Math.abs((moose.y + moose.height/2) - (_player.y + _player.height/2)) < _player.height / 2
					&& moose.x > _player.x) {
				moose.charge();
			}
		}
		
		shouldSpawn = shouldSpawn && (Math.random() > 0.85);
		
		if (shouldSpawn && mooseArr.length < 2) {
			mooseArr.push(new Moose());
			add(mooseArr[mooseArr.length - 1]);
			mooseGroup.add(mooseArr[mooseArr.length - 1]);
			obstacleGroup.add(mooseArr[mooseArr.length - 1]);
		}
	}
	
	private function addRocks(): Void {
		var shouldSpawn: Bool = true;
		var itr: Iterator<Rock> = rockArr.iterator();
		
		for (rock in itr) {
			if (rock.x > FlxG.width / 2)
				shouldSpawn = false;
			else if (rock.x < -rock.width) {
				remove(rock);
				rockArr.remove(rock);
				rockGroup.remove(rock);
				obstacleGroup.remove(rock);
			}
		}
		
		shouldSpawn = shouldSpawn && (Math.random() > 0.5);
		
		if (shouldSpawn && rockArr.length < 4) {
			rockArr.push(new Rock());
			add(rockArr[rockArr.length - 1]);
			rockGroup.add(rockArr[rockArr.length - 1]);
			obstacleGroup.add(rockArr[rockArr.length - 1]);

		}
	}
	
	//----------------------------------------------------
	//---------------COLLECTIBLES FUNCTIONS---------------
	//----------------------------------------------------
	public function updateCollectibles():Void
	{ // spawn random collectables randomdly
		var spawn:Bool = true;
		var itr:Iterator<Collectibles> = collectibleArr.iterator();
		
		for (collectible in itr)
		{
			if (collectible.x > FlxG.width / 2)
			{
				spawn = false;
			}
			else if (collectible.x < -collectible.width)
			{
				remove(collectible);
				collectibleArr.remove(collectible);
				collectibles_layer.remove(collectible);
				//
			}
		}
		
		spawn = spawn && (Math.random() > 0.45);
		
		if (spawn && collectibleArr.length < 4)
		{
			collectibleArr.push(new Collectibles());
			add(collectibleArr[collectibleArr.length -1]);
			collectibles_layer.add(collectibleArr[collectibleArr.length -1]);
		}
	}
	
	//--------------------------------------------
	//---------------MISC FUNCTIONS---------------
	//--------------------------------------------
	private function blockMovement(ob1:FlxObject, ob2:FlxObject): Void {
		if (ob1.immovable) {
			ob2.x = ob1.x + ob1.width;
		}
	}
	
	//FOR TESTING
	private function clickToChange():Void 
	{
		var nextTown = new TownState();
		nextTown.init(_difficulty, party);
		FlxG.switchState(nextTown);
		super.create();
	}
	
}