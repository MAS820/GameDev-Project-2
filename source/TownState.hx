package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class TownState extends FlxState
{	
	private var _npc : NPCsprite;
	private var _questList : Array<QuestsClass>;
	private var questText : FlxText;
	private var tempText : FlxText;
	private var party : PartyClass;
	private var leaveBTN : FlxButton;
	
    override public function create():Void
    {
        super.create();
		
		//array of quests
		_questList = new Array();
		_questList = [new QuestsClass(3, "water")];
		
		
		//background
		add(new FlxSprite(0, 0, "assets/images/townBG.png"));
		
		//npc
		_npc = new NPCsprite(300, 300, "assets/images/npc.png", 0);
		add(_npc);
		
		//Leave Town Button
		leaveBTN = new FlxButton(200, 200, "Leave Town", leaveTown);
		add(leaveBTN);
		
		//party variable created
		party = new PartyClass();
    }

    override public function update():Void
    {
		
		//ALL OF THIS IS FOR TESTING, WILL BE CHANGED
		///////////////////////////////////////////////////////
		//change this to check if the npc is clicked on
		if (FlxG.keys.justPressed.SPACE)
		{
			//create a function that recieves the clicked on npc
			//Outputs that npc's quest dialog
			//Replace content of this if with the new function
			questText = new FlxText(0, 0, 500);
			questText.text = _questList[_npc._questNum]._dialog;
			add(questText);	
		}
		
		if (FlxG.keys.justPressed.E)
		{
			var tempType = _questList[_npc._questNum]._needType;
			var tempNum = _questList[_npc._questNum]._needNum;
			if (_questList[_npc._questNum].checkComp(party.getNum(tempType), tempNum))
			{
				tempText = new FlxText(150, 150, 500);
				tempText.text = "COMPLETE!";
				add(tempText);
			}
		}
		/////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////
		
        super.update();
    }
	
	public function leaveTown():Void
	{
		FlxG.switchState(new ScrollState());
	}

    override public function destroy():Void
    {
        super.destroy();
    }
}