package;

import flixel.FlxSprite;
import flixel.FlxG;
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
	
    override public function new():Void
    {
        super(0, 0);
		x = FlxG.width;
		y = Math.random() * 490 + (FlxG.height - 490);

		var typeGen:Float = Math.random();
		velocity.x = -300;
		
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
		
		y -= height;
		if (y < (FlxG.height - 490 - height / 2)) {
			y = FlxG.height - 490 - height / 2;
		}
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