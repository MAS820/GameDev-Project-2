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
	private var party: PartyClass;

	private var mooseArr: Array<Moose>;
	private var mooseGroup: FlxTypedGroup<Moose>;
	
	private var rockArr: Array<Rock>;
	private var rockGroup: FlxTypedGroup<Rock>;
	
	private var obstacleGroup: FlxGroup;
	
	private var collectibleArr:Array<Collectibles>;
	private var collectibles_layer:FlxTypedGroup<Collectibles>;
	
	private var _difficulty: Int;
	
	private var minusText: FlxText;
	
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
		party = new PartyClass();
		
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
		_testBTN = new FlxButton(10,70,"Go to town", clickToChange);
		add(_testBTN);
	}
	
	public function init(diff: Int, p: PartyClass) {
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
		
		_player.init(party);
		
		FlxSpriteUtil.bound(_player, 0, FlxG.width, 448, FlxG.height);
		
		addRocks();
		
		// for levels past the first, add moose
		if (_difficulty > 0)
			updateMoose();
			
		updateCollectibles();
		
		// TODO: determine if the objects need to be destroyed / how we deal with collisions
		FlxG.overlap(_player, obstacleGroup, damagePlayer);
		FlxG.overlap(_player, collectibles_layer, getCollectible);
		
		if (party._carHealth <= 0) {
			// make a game over
			openSubState(new GameOverState(FlxColor.BLACK));
		}
		else if (_player.timeLeft <= 0) {
			var transition = new TransitionState(FlxColor.BLACK);
			transition.init(_difficulty + 1, party);
			openSubState(transition);
		}
		
		// update the HUD
		scrollHud.updateHUD(party._carHealth, party._alcoholLevel);
		
		if (minusText != null && minusText.alpha >= 0.01) {
			minusText.alpha -= 0.01;
			minusText.x = _player.x + _player.width / 2 - minusText.width / 2;
			minusText.y = _player.y - 20;
		}
	}
	
	private function damagePlayer(ob1: FlxObject, ob2: FlxObject): Void {
		if (!_player.isInvincible) {
			// chance = 0.5(sqrt(100^2 - x^2) +/- (0..10))
			var chanceOfLoss = Math.sqrt(10000 - (party._carHealth) * (party._carHealth));
			chanceOfLoss += Math.random() * 10 - 5;
			chanceOfLoss /= 2;
			trace(Std.string(chanceOfLoss));
			if (Math.random() * 100 < chanceOfLoss && party._followers > 0) {
				party._followers--;
				
				remove(minusText);
				minusText = new FlxText(_player.x + _player.width / 2, _player.y - 20, 100, "-1 follower", 14);
				minusText.x -= minusText.width / 2;
				add(minusText);
				Timer.delay(hideText, 1500);
			}
			
			_player.takeDamage();
		}
	}
	
	private function hideText(): Void {
		remove(minusText);
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
	{ // spawn random collectables randomly
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
	
	public function getCollectible(player:FlxSprite, collect:Collectibles):Void
	{
		party.addInventory(collect.type, 1);
		collectibles_layer.remove(collect);
		collectibleArr.remove(collect);
		remove(collect);
	}
	
	//--------------------------------------------
	//---------------MISC FUNCTIONS---------------
	//--------------------------------------------
	
	//FOR TESTING
	private function clickToChange():Void 
	{
		var transition = new TransitionState(FlxColor.BLACK);
		transition.init(_difficulty + 1, party);
		openSubState(transition);
	}
	
}