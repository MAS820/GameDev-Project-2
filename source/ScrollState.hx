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
import flixel.util.FlxRandom;
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
	
	private var whirlArr:Array<Whirlwind>;
	private var whirlGroup:FlxTypedGroup<Whirlwind>;
	
	private var obstacleGroup: FlxGroup;
	
	private var collectibleArr:Array<Collectibles>;
	private var collectibles_layer:FlxTypedGroup<Collectibles>;
	
	private var minusText: FlxText;
	private var InventoryHUD : FlxSprite;
	private var numWater : FlxText;
	private var numFood : FlxText;
	private var numMedicine : FlxText;
	private var numMoney : FlxText;
	private var numFollower : FlxText;
	
	//FOR TESTING
	//private var _testBTN : FlxButton;

	//------------------------------------
	//---------------CREATE---------------
	//------------------------------------
	override public function create():Void
	{
		super.create();
	
		FlxG.mouse.visible = false;
		
		FlxG.sound.playMusic("assets/sounds/scrollMusic.ogg", 1, true);
		
		// DEBUG MODE
		
		FlxG.debugger.drawDebug = true;
		
		// ensure our world (collision detection) is set properly
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		
		//--------------------------------------
		//---------------PARALLAX---------------
		//--------------------------------------
		backdrop = new FlxBackdrop("assets/images/Parallax_0_short.png");
		backdrop.y = 75;
		backdrop.velocity.x = -200;
		add(backdrop);
		
		road = new FlxBackdrop("assets/images/road.png", 0, 0, true, false);
		road.y = 208;
		road.velocity.x = -500;
		add(road);
		
		//-------------------------------------
		//---------------SPRITES---------------
		//-------------------------------------
		
		rockArr = new Array<Rock>();
		rockGroup = new FlxTypedGroup<Rock>();
		
		mooseArr = new Array<Moose>();
		mooseGroup = new FlxTypedGroup<Moose>();
		
		whirlArr = new Array<Whirlwind>();
		whirlGroup = new FlxTypedGroup<Whirlwind>();
		
		obstacleGroup = new FlxGroup();
		obstacleGroup.add(rockGroup);
		obstacleGroup.add(mooseGroup);
		obstacleGroup.add(whirlGroup);
		add(obstacleGroup);
		
		collectibleArr = new Array<Collectibles>();
		collectibles_layer = new FlxTypedGroup<Collectibles>();
		add(collectibles_layer);
		
		_player = new Truck(100, 450);
		add(_player);
		
		//---------------------------------
		//---------------HUD---------------
		//---------------------------------		
		scrollHud = new HUD(_player);
		add(scrollHud);
		
		//inventory HUD
		InventoryHUD = new FlxSprite();
		InventoryHUD.loadGraphic("assets/images/HotBar_2.png");
		InventoryHUD.scale.set(0.35, 0.35);
		InventoryHUD.x = FlxG.width - (InventoryHUD.width * .85);
		InventoryHUD.y = FlxG.height - (InventoryHUD.height * 1.18);
		add(InventoryHUD);
		
		numFood = new FlxText(283,122);
		numFood.text = Std.string(party.getNum("food"));
		numFood.size = 15;
		numFood.color = FlxColor.RED;
		add(numFood);
		
		numWater = new FlxText(366,122);
		numWater.text = Std.string(party.getNum("water"));
		numWater.size = 15;
		numWater.color = FlxColor.RED;
		add(numWater);
		
		numMoney = new FlxText(448,122);
		numMoney.text = Std.string(party.getNum("money"));
		numMoney.size = 15;
		numMoney.color = FlxColor.RED;
		add(numMoney);
		
		numMedicine = new FlxText(535,122);
		numMedicine.text = Std.string(party.getNum("medicine"));
		numMedicine.size = 15;
		numMedicine.color = FlxColor.RED;
		add(numMedicine);
		
		numFollower = new FlxText(618, 122);
		numFollower.text = Std.string(party._followers);
		numFollower.size = 15;
		numFollower.color = FlxColor.RED;
		add(numFollower);
		
		//FOR TESTING
		//_testBTN = new FlxButton(10,70,"Go to town", clickToChange);
		//add(_testBTN);
		
		FlxRandom.resetGlobalSeed();
	}
	
	public function init(p: PartyClass) {
		party = p;
	}
	
	//-------------------------------------
	//---------------DESTROY---------------
	//-------------------------------------
	override public function destroy():Void
	{
		var itr = obstacleGroup.iterator();
		for (i in itr) {
			i.destroy();
		}
		super.destroy();
	}
	
	//------------------------------------
	//---------------UPDATE---------------
	//------------------------------------
	override public function update():Void
	{
		super.update();
		
		_player.init(party);
		
		FlxSpriteUtil.bound(_player, 0, FlxG.width, 208, FlxG.height - 25 + _player.frameHeight - _player.height);
		
		addRocks();
		
		// add whirlwind for final level
		if (party._level > 1)
			updateWhirlwind();
		
		// for levels past the first, add moose
		if (party._level > 0)
			updateMoose();
			
		updateCollectibles();
		
		// damage the player or give them a powerup as necessary
		FlxG.overlap(_player, obstacleGroup, damagePlayer);
		FlxG.overlap(_player, collectibles_layer, getCollectible);
		
		if (party._carHealth <= 0) {
			// make a game over
			openSubState(new GameOverState(FlxColor.BLACK));
		}
		else if (_player.timeLeft <= 0) {
			var transition = new TransitionState(FlxColor.BLACK);
			transition.init(party);
			openSubState(transition);
		}
		
		// update the HUD
		scrollHud.updateHUD(party._carHealth, party._alcoholLevel);
		
		if (minusText != null && minusText.alpha >= 0.01) {
			minusText.alpha -= 0.01;
			minusText.x = _player.x + _player.width / 2 - minusText.width / 2;
			minusText.y = _player.y - 20;
		}
		
		numMoney.text = Std.string(party.getNum("money"));
		numMedicine.text = Std.string(party.getNum("medicine"));
		numFood.text = Std.string(party.getNum("food"));
		numWater.text = Std.string(party.getNum("water"));
		numFollower.text = Std.string(party._followers);
	}
	
	private function damagePlayer(ob1: FlxObject, ob2: FlxObject): Void {
		if (!_player.isInvincible) {
			// chance = 0.5(sqrt(100^2 - x^2) +/- (0..10))
			var chanceOfLoss = Math.sqrt(10000 - (party._carHealth) * (party._carHealth));
			chanceOfLoss += FlxRandom.floatRanged(-5, 5);
			chanceOfLoss /= 4;
			if (FlxRandom.floatRanged(0, 100) < chanceOfLoss && party._followers > 0) {
				party._followers--;
				var txt = remove(minusText);
				if (txt != null)
					txt.destroy();
				minusText = new FlxText(_player.x + _player.width / 2, _player.y - 20, 100, "-1 follower", 14);
				minusText.x -= minusText.width / 2;
				add(minusText);
				Timer.delay(hideText, 1500);
			}
			
			if (Type.getClassName(Type.getClass(ob2)) == "Rock") {
				_player.takeDamage(5);
			}
			else if (Type.getClassName(Type.getClass(ob2)) == "Moose") {
				_player.takeDamage(7);
			}
			else {
				_player.takeDamage(10);
			}
		}
	}
	
	private function hideText(): Void {
		remove(minusText).destroy();
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
				mooseArr.remove(moose);
				mooseGroup.remove(moose).destroy();
			}
			// make the moose charge if it sees the player
			if (Math.abs((moose.y + moose.height/2) - (_player.y + _player.height/2)) < _player.height / 2
					&& moose.x > _player.x) {
				moose.charge();
			}
		}
		
		shouldSpawn = shouldSpawn && (FlxRandom.float() > 0.95);
		
		if (shouldSpawn && mooseArr.length < 2) {
			mooseArr.push(new Moose());
			// make sure the moose isn't overlapping any other obstacles
			while (FlxG.overlap(mooseArr[mooseArr.length - 1], obstacleGroup) ||
					FlxG.overlap(mooseArr[mooseArr.length - 1], collectibles_layer)) {
				mooseArr.pop().destroy();
				mooseArr.push(new Moose());
			}
			mooseGroup.add(mooseArr[mooseArr.length - 1]);
		}
	}
	
	private function addRocks(): Void {
		var shouldSpawn: Bool = true;
		var itr: Iterator<Rock> = rockArr.iterator();
		
		for (rock in itr) {
			if (rock.x > 3 * FlxG.width / 5)
				shouldSpawn = false;
			else if (rock.x < -rock.width) {
				rockArr.remove(rock);
				rockGroup.remove(rock).destroy();
			}
		}
		
		if (party._level == 0)
			shouldSpawn = shouldSpawn && (FlxRandom.float() > 0.5) && rockArr.length < 4;
		else
			shouldSpawn = shouldSpawn && (FlxRandom.float() > 0.8) && rockArr.length < 3;
		
		if (shouldSpawn) {
			rockArr.push(new Rock());
			while (FlxG.overlap(rockArr[rockArr.length - 1], obstacleGroup) ||
					FlxG.overlap(rockArr[rockArr.length - 1], collectibles_layer)) {
				rockArr.pop().destroy();
				rockArr.push(new Rock());
			}
			rockGroup.add(rockArr[rockArr.length - 1]);

		}
	}
	
	private function updateWhirlwind():Void
	{
		var spawn:Bool = true;
		var itr:Iterator<Whirlwind> = whirlArr.iterator();
		
		for (whirlwind in itr) {
			whirlwind.update();
			if (whirlwind.x > FlxG.width / 2)
			{
				spawn = false;
			}
			else if (whirlwind.x < -whirlwind.width)
			{
				whirlArr.remove(whirlwind);
				whirlGroup.remove(whirlwind).destroy();
			}
		}
		
		spawn = spawn && (FlxRandom.float() < 0.01);
		
		if (spawn && whirlArr.length < 1)
		{
			whirlArr.push(new Whirlwind());
			whirlGroup.add(whirlArr[whirlArr.length - 1]);
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
				collectibleArr.remove(collectible);
				collectibles_layer.remove(collectible).destroy();
			}
		}
		
		spawn = spawn && (FlxRandom.float() > 0.45);
		
		if (spawn && collectibleArr.length < 4)
		{
			collectibleArr.push(new Collectibles(party._level > 2));
			while (FlxG.overlap(collectibleArr[collectibleArr.length - 1], obstacleGroup)) {
				collectibleArr.pop().destroy();
				collectibleArr.push(new Collectibles(party._level > 2));
			}
			collectibles_layer.add(collectibleArr[collectibleArr.length -1]);
		}
	}
	
	public function getCollectible(player:FlxSprite, collect:Collectibles):Void
	{
		party.addInventory(collect.type, 1);
		collectibleArr.remove(collect);
		collectibles_layer.remove(collect).destroy();
	}
	
	//--------------------------------------------
	//---------------MISC FUNCTIONS---------------
	//--------------------------------------------
	
	//FOR TESTING
	private function clickToChange():Void 
	{
		var transition = new TransitionState(FlxColor.BLACK);
		transition.init(party);
		openSubState(transition);
	}
	
}