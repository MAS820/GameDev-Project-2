package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author 
 */
class IntroState extends FlxState
{
	private var txt: FlxText;
	
	override public function create(): Void
	{
		super.create();
		
		txt = new FlxText(0, 0, 2*FlxG.width / 3,
			"In the not so near future, Canada will be invaded by an enemy " +
			"that no country has ever had to face– a moose stampede, " + 
			"the largest the world has ever seen. " + 
			"Hooch and Holly, an alcoholic and her niece, " + 
			"have survived the attack so far, " + 
			"but there are many people who cannot fend for themselves against the deadly stampede. " + 
			"Holly, out of the kindness of her heart, " + 
			"has decided to travel across the Canadian map to " + 
			"rescue those in need during this disastrous moose invasion.", 18);
		
		txt.screenCenter();
		txt.alignment = "center";
		add(txt);
		
		function startGame():Void
		{
			FlxG.switchState(new MenuState());
		}
		
		var playButton = new FlxButton(txt.x + txt.width/2, txt.y + txt.height + 10, "Continue", startGame);
		playButton.x -= playButton.width / 2;
		add(playButton);
	}
}