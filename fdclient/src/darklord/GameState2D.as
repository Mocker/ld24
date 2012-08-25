package darklord
{
	
	
	/**
	 * darklord.GameState
	 * 
	 * Virtual class to layout common update -> render cycle, handle event hooks
	 * links to engines scene object
	 * 
	 * */
	
	
	import darklord.net.NetMSG;
	
	
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;

	import org.flixel.FlxState;
		
	public class GameState2D extends Sprite
	{
		public var eng:Engine2D;
		public function GameState2D(engine:Engine2D):void
		{
			super();
			this.eng = engine;
		}
		
		public function init():void
		{
		}
		
		
		public function update():void
		{
				
		}
		
		public function render():void
		{
			
		}
		
		
		
		//INPUT handlers - state overwrites any it needs
		// INPUT HANDLERS //
		public function onMouseClick(ev:Event):void 
		{
			
		}
		public function onMouseUp(ev:Event):void 
		{
			
		}
		public function onMouseDown(ev:Event):void 
		{
			
		}
		
		public function onKeyDown(ev:Event):void 
		{
			
		}
		public function onKeyUp(ev:Event):void 
		{
			
		}
		
		//place holders for network events
		public function onNetConnect(ev):void
		{
			
		}
		public function onNetMSG(ev:NetMSG):void
		{
			
		}
		public function onNetClose(ev:*):void
		{
			
		}
		public function onNetError(ev:*):void
		{
			
		}
	}
}