package;

import flixel.FlxSprite;
import flixel.FlxG;

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
        super(FlxG.width, Math.random() * (FlxG.height - 450) + 450);
		var typeGen:Float = Math.random();
		velocity.x = -300;
		
		if (typeGen >= 0.8) {
			type = "money";
			loadGraphic("assets/images/money.png", false, 40, 40);
		}
		
		else if (typeGen >= 0.6) {
			type = "food";
			loadGraphic("assets/images/food.png");
		}
		
		else if (typeGen >= 0.4) {
			type = "water";
			loadGraphic("assets/images/water.png");
		}
		
		else if (typeGen >= 0.2) {
			type = "booze";
			loadGraphic("assets/images/booze.png");
		}
		
		else {
			type = "medicine";
			loadGraphic("assets/images/medicine.png");
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