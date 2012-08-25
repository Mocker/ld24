package
{
	import darklord.Engine2D;
	
	import flash.display.Sprite;
	import org.flixel.FlxGame;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW",width="800",height="600")]
	public class Evo extends Sprite
	{
		private var engine:Engine2D;
		
		public function Evo()
		{
			trace("main name: "+this.name);
			engine = new Engine2D();
			this.addChild(engine);
			engine.init();
		}
	}
}