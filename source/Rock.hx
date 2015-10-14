package;

import flixel.FlxG;

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
		
		x = FlxG.width;
		y = Math.random() * 490 + (FlxG.height - 490) - height;
		if (y < (FlxG.height - 490 - height / 2)) {
			y = FlxG.height - 490 - height / 2;
		}
	}
}