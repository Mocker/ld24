package darklord.states
{
	
	import darklord.Engine2D;
	import darklord.GameState2D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.*;
	import flash.utils.*;
	
	public class PlayState extends GameState2D
	{
		
		
		
		public function PlayState(engine:Engine)
		{
			super(engine);
			this.name = "PlayState";
		}
		
		
		override public function init():void 
		{
			super.init();
		}
		
		override public function onMouseClick(ev:Event):void
		{
			
		}
		
		override public function onKeyDown(ev:Event):void
		{
			
		}
		
		override public function onKeyUp(ev:Event):void
		{
			
		}
		
	}
}