package darklord.states
{
	
	import darklord.Engine2D;
	import darklord.GameState2D;
	import darklord.net.NetMSG;
	
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
		
		
		
		public function PlayState(engine:Engine2D)
		{
			super(engine);
			this.name = "PlayState";
		}
		
		
		override public function init():void 
		{
			super.init();
			initBG();
		}
		
		private function initBG():void
		{
			var bgRect:Sprite = new Sprite();
			bgRect.name="bgRect";
			bgRect.graphics.beginGradientFill(GradientType.RADIAL, [0xcccccc, 0xccccff], [1,1],[200,250]);
			bgRect.graphics.drawRect(0,0, this.eng.gameWidth, this.eng.gameHeight);
			this.addChild(bgRect);
			
			
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
		
		override public function onNetMSG(msg:NetMSG):void
		{
			//alert.show(msg.dataEvent.data);
			trace("msg code: " + msg.code + " : " + msg.msg);
		}
	}
}