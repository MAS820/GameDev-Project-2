package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class TownState extends FlxState
{
    override public function create():Void
    {
        super.create();
		add(new FlxSprite(0, 0, "assets/images/townBG.png"));
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