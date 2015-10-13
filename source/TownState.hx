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
	private var shopkeeper : NPCsprite;
	private var repairperson : NPCsprite;
	private var npc1 : NPCsprite;
	private var npc2 : NPCsprite;
	private var npc3 : NPCsprite;
	
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
	private var buyRepairBTN : FlxButton;
	private var xBTN : FlxButton;
	
	//item counters
	private var numWater : FlxText;
	private var numFood : FlxText;
	private var numMedicine : FlxText;
	private var numMoney : FlxText;
	
	//screen stuff
	private var party : PartyClass;
	private var mSprite : MouseSprite;
	private var questHUD : HUDsprite;
	private var InventoryHUD : FlxSprite;
	private var BG : FlxSprite;
	
	private var level: Int;
	private var scrollHud: HUD;
	
    override public function create():Void
    {
        super.create();
		
		//array of quests
		_questList = new Array();
		
		//0 = shopkeeper, 1 = repair person, 2-5 = 1st stop 
		_questList = [new QuestsClass(0, "money"), new QuestsClass(0, "money"), new QuestsClass(5, "water"),
		new QuestsClass(5, "food"), new QuestsClass(5, "money"), new QuestsClass(5, "medicine")];
		
		tempType = "";
		tempNum = 0;
		quest = 0;
		
		//background
		BG = new FlxSprite(0, 0, "assets/images/City_0.png");
		BG.scale.set(0.5,0.5);
		BG.screenCenter();
		add(BG);
		
		//npc
		
		/*
		shopkeeper = new NPCsprite(0, 0, "assets/images/Shopkeeper.png", 0);
		shopkeeper.y = shopkeeper.y + 50;
		shopkeeper.scale.set(0.25, 0.25);
		add(shopkeeper);
		
		repairperson = new NPCsprite(0, 0, "assets/images/Mechanic.png", 1);
		repairperson.y = repairperson.y + 50;
		repairperson.x = repairperson.x - 600;
		repairperson.scale.set(0.25, 0.25);
		add(repairperson);
		*/
		
		shopkeeper = new NPCsprite(550, 300, "assets/images/npc.png", 0);
		add(shopkeeper);
		repairperson = new NPCsprite(300, 300, "assets/images/npc.png", 1);
		add(repairperson);
		npc1 = new NPCsprite(50, 300, "assets/images/npc.png", 2);
		add(npc1);
		npc2 = new NPCsprite(800, 300, "assets/images/npc.png", 3);
		add(npc2);
		npc3 = new NPCsprite(800, 450, "assets/images/npc.png", 4);
		add(npc3);
		
		NPCgroup = new FlxGroup(5);
		NPCgroup.add(shopkeeper);
		NPCgroup.add(repairperson);
		NPCgroup.add(npc1);
		NPCgroup.add(npc2);
		NPCgroup.add(npc3);
		
		//scroll HUD
		var tempTruck = new Truck();
		tempTruck.init(party);
		scrollHud = new HUD(tempTruck);
		scrollHud._txtTimer.visible = false;
		add(scrollHud);
		
		//Leave Town Button
		leaveBTN = new FlxButton(FlxG.width / 2 + 350, 80, "Leave Town", leaveTown);
		add(leaveBTN);
		
		//HUD
		questHUD = new HUDsprite();
		questHUD.makeGraphic(700, 300, FlxColor.BLACK);
		add(questHUD);
		questHUD.screenCenter();
		questHUD.visible = false;
		
		//inventory HUD
		InventoryHUD = new FlxSprite();
		InventoryHUD.loadGraphic("assets/images/HotBar_2.png");
		InventoryHUD.scale.set(0.35, 0.35);
		InventoryHUD.x = FlxG.width - (InventoryHUD.width * .85);
		InventoryHUD.y = FlxG.height - (InventoryHUD.height * 1.18);
		add(InventoryHUD);
		
		
		//Give button
		giveBTN = new FlxButton(FlxG.width/2,questHUD.y + questHUD.y+50,"Give", checkInventory);
		add(giveBTN);
		giveBTN.visible = false;
		
		//x out button
		xBTN = new FlxButton(questHUD.x + 600, questHUD.y+5, "X", closeQuest);
		add(xBTN);
		xBTN.visible = false;
		
		//shop buttons
		buyWaterBTN = new FlxButton(FlxG.width/2,questHUD.y + questHUD.y+50,"water", buyWater);
		buyFoodBTN = new FlxButton(FlxG.width/2 + 100,questHUD.y + questHUD.y+50,"food", buyFood);
		buyMedicineBTN = new FlxButton(FlxG.width/2 - 100,questHUD.y + questHUD.y+50,"medicine", buyMedicine);
		buyRepairBTN = new FlxButton(FlxG.width/2,questHUD.y + questHUD.y+50, "repair", repairCar);
		
		add(buyFoodBTN);
		add(buyMedicineBTN);
		add(buyWaterBTN);
		add(buyRepairBTN);
		
		buyFoodBTN.visible = false;
		buyMedicineBTN.visible = false;
		buyWaterBTN.visible = false;
		buyRepairBTN.visible = false;
		
		//Quest text
		questText = new FlxText(questHUD.x, questHUD.y+30, questHUD.width);
		questText.size = 25;
		add(questText);	
		questText.visible = false;
		
		//inventory counters
		numFood = new FlxText(322,122);
		numFood.text = Std.string(party.getNum("food"));
		numFood.size = 15;
		numFood.color = FlxColor.RED;
		add(numFood);
		
		numWater = new FlxText(406,122);
		numWater.text = Std.string(party.getNum("water"));
		numWater.size = 15;
		numWater.color = FlxColor.RED;
		add(numWater);
		
		numMoney = new FlxText(488,122);
		numMoney.text = Std.string(party.getNum("money"));
		numMoney.size = 15;
		numMoney.color = FlxColor.RED;
		add(numMoney);
		
		numMedicine = new FlxText(575,122);
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
		
		scrollHud.updateHUD(party._carHealth, party._alcoholLevel);
		
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
				questHUD.visible = true;
				buyFoodBTN.visible = true;
				buyMedicineBTN.visible = true;
				buyWaterBTN.visible = true;
				xBTN.visible = true;
			}else if (obj._questNum == 1) 
			{
				//Replace with creating a quest HUD for a shop
				questText.text = "Need repairs? $5 for 10 health";
				
				//construct questHUD for a shop
				questText.visible = true;
				questHUD.visible = true;
				buyRepairBTN.visible = true;
				xBTN.visible = true;
			}else{
				//Replace with creating a quest HUD
				questText.text = _questList[obj._questNum]._dialog;
				tempType = _questList[obj._questNum]._needType;
				tempNum = _questList[obj._questNum]._needNum;
				quest = obj._questNum;
				
				//construct questHUD
				questText.visible = true;
				questHUD.visible = true;
				giveBTN.visible = true;
				xBTN.visible = true;
			}
		}
	}
	
	//used to buy items from the shop
	//////////////////////////////////////////////////////
	public function repairCar():Void
	{
		if (buyRepairBTN.visible == true)
		{
			if (party.getNum("money") >= 5 && party._carHealth < 100)
			{
				if (100 - party._carHealth < 10)
				{
					party._money = party._money - 5;
					party._carHealth = party._carHealth + (100 - party._carHealth);
					updateItemCounters();
				}else{
					party._money = party._money - 5;
					party._carHealth = party._carHealth + 10;
					updateItemCounters();
				}
			}
		}
	}
	
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
			questHUD.visible = false;
			questText.visible = false;
			giveBTN.visible = false;
			buyFoodBTN.visible = false;
			buyMedicineBTN.visible = false;
			buyWaterBTN.visible = false;
			buyRepairBTN.visible = false;
			xBTN.visible = false;
		}
	}
	
	public function leaveTown():Void
	{
		if (level + 1 >= 2) {
			// TODO: end screen stuff
		}
		
		var next = new ScrollState();
		party._alcoholLevel = 0;
		next.init(level + 1, party);
		FlxG.switchState(next);
	}

    override public function destroy():Void
    {
        super.destroy();
		
		FlxG.mouse.unload();
    }
}