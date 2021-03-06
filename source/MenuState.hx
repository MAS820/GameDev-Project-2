package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.display.FlxBackdrop;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	public var backdrop:FlxBackdrop;
	public var road:FlxBackdrop;
	public var party:PartyClass;
	
	override public function create():Void
	{
		super.create();
		
		backdrop = new FlxBackdrop("assets/images/Parallax_0.png");
		backdrop.velocity.x = -200;
		add(backdrop);
		
		road = new FlxBackdrop("assets/images/road.png", 0, 0, true, false);
		road.y = 475;
		road.velocity.x = -750;
		add(road);
		
		var car = new FlxSprite();
		car.loadGraphic("assets/images/truck.png");
		car.setGraphicSize(200, 0);
		car.updateHitbox();
		add(car);
		car.x = 390;
		car.y = 520;
		
		var title = new FlxText(200, 100, 600);
		title.text = "Ontario Trail";
		title.size = 64;
		add(title);
		
		party = new PartyClass();
		
		function startGame():Void
		{
			var start = new ScrollState();
			start.init(party);
			FlxG.switchState(start);
		}
		
		var playButton = new FlxButton(400, 300, "Play", startGame);
		add(playButton);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}