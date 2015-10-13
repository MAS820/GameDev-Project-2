package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;

using flixel.util.FlxSpriteUtil;

class TownState extends FlxState
{	
	//npc group and definitions
	private var NPCgroup : FlxGroup;
	private var _npc : NPCsprite;
	private var _npc2 : NPCsprite;
	
	//Quest text and dialog
	private var _questList : Array<QuestsClass>;
	private var questText : FlxText;
	
	//Quest temps
	private var tempType : String;
	private var tempNum : Int;
	private var quest : Int;
	
	//Buttons
	private var leaveBTN : FlxButton;
	private var giveBTN : FlxButton;
	private var buyWaterBTN : FlxButton;
	private var buyFoodBTN : FlxButton;
	private var buyMedicineBTN : FlxButton;
	private var xBTN : FlxButton;
	
	//item counters
	private var numWater : FlxText;
	private var numFood : FlxText;
	private var numMedicine : FlxText;
	private var numMoney : FlxText;
	
	//screen stuff
	private var party : PartyClass;
	private var mSprite : MouseSprite;
	private var HUD : HUDsprite;
	private var InventoryHUD : FlxSprite;
	
	private var level: Int;
	
    override public function create():Void
    {
        super.create();
		
		//array of quests
		_questList = new Array();
		_questList = [new QuestsClass(0, "money"), new QuestsClass(5, "water")];
		
		tempType = "";
		tempNum = 0;
		quest = 0;
		
		//background
		add(new FlxSprite(0, 0, "assets/images/townBG.png"));
		
		//npc
		_npc = new NPCsprite(300, 300, "assets/images/npc.png", 0);
		add(_npc);
		_npc2 = new NPCsprite(200, 300, "assets/images/npc.png", 1);
		add(_npc2);
		
		NPCgroup = new FlxGroup(2);
		NPCgroup.add(_npc);
		NPCgroup.add(_npc2);
		
		//Leave Town Button
		leaveBTN = new FlxButton(FlxG.width-100, FlxG.height-700, "Leave Town", leaveTown);
		add(leaveBTN);
		
		//HUD
		HUD = new HUDsprite();
		HUD.makeGraphic(700, 500, FlxColor.BLACK);
		add(HUD);
		HUD.screenCenter();
		HUD.visible = false;
		
		//inventory HUD
		InventoryHUD = new FlxSprite();
		InventoryHUD.loadGraphic("assets/images/HotBar_2.png");
		InventoryHUD.scale.set(0.35, 0.35);
		InventoryHUD.x = FlxG.width - (InventoryHUD.width*.85);
		add(InventoryHUD);
		
		
		//Give button
		giveBTN = new FlxButton(HUD.x+(HUD.x*2)+30,HUD.y+(HUD.y*4),"Give", checkInventory);
		add(giveBTN);
		giveBTN.visible = false;
		
		//x out button
		xBTN = new FlxButton(HUD.x + 600, HUD.y+5, "X", closeQuest);
		add(xBTN);
		xBTN.visible = false;
		
		//shop buttons
		buyWaterBTN = new FlxButton(HUD.x+500,HUD.y+(HUD.y*4),"water", buyWater);
		buyFoodBTN = new FlxButton(HUD.x+350,HUD.y+(HUD.y*4),"food", buyFood);
		buyMedicineBTN = new FlxButton(HUD.x+200,HUD.y+(HUD.y*4),"medicine", buyMedicine);
		
		add(buyFoodBTN);
		add(buyMedicineBTN);
		add(buyWaterBTN);
		
		buyFoodBTN.visible = false;
		buyMedicineBTN.visible = false;
		buyWaterBTN.visible = false;
		
		//Quest text
		questText = new FlxText(HUD.x, HUD.y+30, HUD.width);
		questText.size = 25;
		add(questText);	
		questText.visible = false;
		
		//inventory counters
		numFood = new FlxText(322,672);
		numFood.text = Std.string(party.getNum("food"));
		numFood.size = 15;
		numFood.color = FlxColor.RED;
		add(numFood);
		
		numWater = new FlxText(405,672);
		numWater.text = Std.string(party.getNum("water"));
		numWater.size = 15;
		numWater.color = FlxColor.RED;
		add(numWater);
		
		numMoney = new FlxText(488,672);
		numMoney.text = Std.string(party.getNum("money"));
		numMoney.size = 15;
		numMoney.color = FlxColor.RED;
		add(numMoney);
		
		numMedicine = new FlxText(571,672);
		numMedicine.text = Std.string(party.getNum("medicine"));
		numMedicine.size = 15;
		numMedicine.color = FlxColor.RED;
		add(numMedicine);
		
		//mouse sprite
		mSprite = new MouseSprite();
		add(mSprite);
		FlxG.mouse.visible = false;
    }

    override public function update():Void
    {
		//mSprite follows mouse
		mSprite.setPosition(FlxG.mouse.x - 20, FlxG.mouse.y - 20);
		
		//checks what mSprite is overlapping
		FlxG.overlap(mSprite, NPCgroup, checkClickOn);
		
        super.update();
    }
	
	public function init(lv: Int, p : PartyClass) {
		level = lv;
		party = p;
	}
	
	//given mSprtie and the npc who was clicked on
	public function checkClickOn(mSprite, obj):Void
	{
		if (FlxG.mouse.justReleased)
		{
			if (obj._questNum == 0)
			{
				//Replace with creating a quest HUD for a shop
				questText.text = "What chu want?";
				
				//construct questHUD for a shop
				questText.visible = true;
				HUD.visible = true;
				buyFoodBTN.visible = true;
				buyMedicineBTN.visible = true;
				buyWaterBTN.visible = true;
				xBTN.visible = true;
			}else{
				//Replace with creating a quest HUD
				questText.text = _questList[obj._questNum]._dialog;
				tempType = _questList[obj._questNum]._needType;
				tempNum = _questList[obj._questNum]._needNum;
				quest = obj._questNum;
				
				//construct questHUD
				questText.visible = true;
				HUD.visible = true;
				giveBTN.visible = true;
				xBTN.visible = true;
			}
		}
	}
	
	//used to buy items from the shop
	//////////////////////////////////////////////////////
	public function buyWater():Void
	{
		if (buyWaterBTN.visible == true)
		{
			if (party.getNum("money") > 0)
			{
				party.addInventory("water", 1);
				party.subInventory("money", 1);
				updateItemCounters();
			}
		}
	}
	
	public function buyFood():Void
	{
		if (buyFoodBTN.visible == true)
		{
			if (party.getNum("money") > 0)
			{
				party.addInventory("food", 1);
				party.subInventory("money", 1);
				updateItemCounters();
			}
		}
	}
	
	public function buyMedicine():Void
	{
		if (buyMedicineBTN.visible == true)
		{	
			if (party.getNum("money") > 0)
			{
				party.addInventory("medicine", 1);
				party.subInventory("money", 1);
				updateItemCounters();
			}
		}
	}
	///////////////////////////////////////////////////////
	
	public function checkInventory():Void
	{
		if (giveBTN.visible = true)
		{
			if (_questList[quest].checkComp(party.getNum(tempType), tempNum))
			{
				questText.text = "COMPLETE!!!";
				party.subInventory(tempType, tempNum);
				party._followers = party._followers + 1;
				giveBTN.visible = false;
				updateItemCounters();
			}else {
				questText.text = "Sorry you don't have enough "+tempType;
			}
		}
	}
	
	public function updateItemCounters():Void
	{
		numMoney.text = Std.string(party.getNum("money"));
		numMedicine.text = Std.string(party.getNum("medicine"));
		numFood.text = Std.string(party.getNum("food"));
		numWater.text = Std.string(party.getNum("water"));
	}
	
	public function closeQuest():Void
	{
		if (xBTN.visible == true)
		{
			HUD.visible = false;
			questText.visible = false;
			giveBTN.visible = false;
			buyFoodBTN.visible = false;
			buyMedicineBTN.visible = false;
			buyWaterBTN.visible = false;
			xBTN.visible = false;
		}
	}
	
	public function leaveTown():Void
	{
		if (level + 1 >= 2) {
			// TODO: end screen stuff
		}
		
		var next = new ScrollState();
		next.init(level + 1, party);
		FlxG.switchState(next);
	}

    override public function destroy():Void
    {
        super.destroy();
		
		FlxG.mouse.unload();
    }
}