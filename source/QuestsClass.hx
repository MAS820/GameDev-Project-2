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
		_dialog = "If you give me "+Std.string(_needNum)+" many "+_needType+" I'll be able to join your party";
	}
	
	public function checkComp(have, need)
	{
		if (have >= need)
			return true;
		else
			return false;
	}
}