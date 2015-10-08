package;

class PartyClass
{
	//Stats
	public var _carHealth : Int;
	public var _alcoholLevel : Int;
	
	//Inventory
	public var _booze : Int;
	public var _food : Int;
	public var _water : Int;
	public var _medicine : Int;
	public var _money : Int;
	
	//number of followers
	public var _followers : Int;
	
	public function new()
	{
		//Stats
		_carHealth = 100;
		_alcoholLevel = 0;
		
		//Inventory
		_booze = 0;
		_food = 0;
		_water = 5;
		_medicine = 0;
		_money = 0;
		
		//number of followers
		_followers = 0;
	}
	
	//returns how much of an item
	//the party currently has
	public function getNum(t)
	{
		if (t == "booze")
			return _booze;
		else if (t == "food")
			return _food;
		else if (t == "water")
			return _water;
		else if (t == "medicine")
			return _medicine;
		else if (t == "money")
			return _money;
		return 0;
	}
}