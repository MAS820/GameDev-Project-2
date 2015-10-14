package;

import flixel.FlxSprite;
import flixel.FlxG;

class NPCsprite extends FlxSprite
{
	//change function new to recieve a quest number to assign
	//to this variable instead of hard coding
	public var _questNum : Int;
	public var finished : Bool;
	
    public function new(x,y,spriteName,quest)
    {
        super(x, y);
		loadGraphic(spriteName);
		_questNum = quest;
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