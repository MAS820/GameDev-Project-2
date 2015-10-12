package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class MouseSprite extends FlxSprite
{
	
    public function new()
    {
        super();
		makeGraphic(40, 40, FlxColor.BLUE);
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