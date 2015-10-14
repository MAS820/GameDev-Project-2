package;

import flixel.FlxG;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class Rock extends Obstacle
{
	public function new()
	{
		super("assets/images/rock.png");
		this.immovable = true;
		setGraphicSize(150, 0);
		updateHitbox();
		
		// now adjust the hitbox for reasonable collisions
		height /= 2;
		offset.y += height;
		
		FlxRandom.resetGlobalSeed();
		
		x = FlxG.width;
		y = FlxRandom.floatRanged(FlxG.height - 490 - height / 2, FlxG.height - height);
	}
}