package;

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
	}
}