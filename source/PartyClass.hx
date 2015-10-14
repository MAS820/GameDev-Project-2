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
	public var _level: Int;
	
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
		_water = 0;
		_medicine = 0;
		_money = 0;
		
		// start on the first level of game
		_level = 0;
		
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
	
	public function subInventory(t, num)
	{
		if (t == "booze") {
			_alcoholLevel -= 5;
			if (_alcoholLevel < 0)
				_alcoholLevel = 0;
		}
		else if (t == "food")
			_food = _food - num;
		else if (t == "water")
			_water = _water - num;
		else if (t == "medicine")
			_medicine = _medicine - num;
		else if(t == "money")
			_money = _money - num;
	}
	
	public function addInventory(t, num)
	{
		if (t == "booze") {
			_alcoholLevel += 5;
			if (_alcoholLevel > 100)
				_alcoholLevel = 100;
		}
		else if (t == "food")
			_food = _food + num;
		else if (t == "water")
			_water = _water + num;
		else if (t == "medicine")
			_medicine = _medicine + num;
		else if (t == "money")
			_money = _money + num;
	}
}