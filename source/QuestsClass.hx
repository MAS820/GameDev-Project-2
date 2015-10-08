package;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class QuestsClass
{
	public var _dialog : String;
	public var _needType : String;
	public var _needNum : Int;
	public var _complete : Bool;
	
	public function new(num, type)
	{
		_needNum = num;
		_needType = type;
		_dialog = "need "+Std.string(_needNum)+" many "+_needType;
	}
	
	public function checkComp(have, need)
	{
		if (have >= need)
			return true;
		else
			return false;
	}
}