package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class MouseSprite extends FlxSprite
{
	
    public function new()
    {
        super();
		loadGraphic("assets/images/Arrow.png");
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