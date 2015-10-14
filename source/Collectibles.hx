package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxRandom;
import PartyClass;

//party.addInventory(TYPE, num);

/**
 * ...
 * @author ...
 */
class Collectibles extends FlxSprite
{
	public var type:String;
	//public var speed:Float;
	
    override public function new(alcoholOnly: Bool = false):Void
    {
        super(0, 0);

		var typeGen: Float;
		
		if (alcoholOnly) {
			typeGen = 0.3;	// alcohol
		} else {
			typeGen = Math.random();
		}
		velocity.x = -500;
		
		if (typeGen >= 0.8) {
			type = "money";
			loadGraphic("assets/images/money.png");
			setGraphicSize(50, 0);
			updateHitbox();
		}
		
		else if (typeGen >= 0.6) {
			type = "food";
			var foodType = Math.floor(Math.random() * 4);
			loadGraphic("assets/images/food_" + Std.string(foodType) + ".png");
			setGraphicSize(50, 0);
			updateHitbox();
		}
		
		else if (typeGen >= 0.4) {
			type = "water";
			loadGraphic("assets/images/water.png");
			setGraphicSize(50, 0);
			updateHitbox();
		}
		
		else if (typeGen >= 0.2) {
			type = "booze";
			var boozeType = Math.floor(Math.random() * 2);
			loadGraphic("assets/images/booze_" + Std.string(boozeType) + ".png");
			setGraphicSize(50, 0);
			updateHitbox();
		}
		
		else {
			type = "medicine";
			loadGraphic("assets/images/medicine.png");
			setGraphicSize(50, 0);
			updateHitbox();
		}
		
		FlxRandom.resetGlobalSeed();
		
		x = FlxG.width;
		y = FlxRandom.floatRanged(FlxG.height - 490 - height / 2, FlxG.height - height);
    }

    override public function update():Void
    {
        super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}