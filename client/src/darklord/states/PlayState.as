package darklord.states
{
	import away3d.containers.View3D;
	
	import darklord.Alert;
	import darklord.Engine;
	import darklord.GameState;
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
	
	public class PlayState extends GameState
	{
		private var titleTXT:TextField = new TextField();
		private var map:Object = new Object(); //TODO:: Create Map class, TileMap class Level class, Tile class
		
		public function PlayState(engine:Engine)
		{
			super(engine);
			this.name = "PlayState";
		}
		
		
		override public function init(view:View3D,params:*=null):void 
		{
			super.init(view);
			
			initGUI();
			initMAP();
			
			
		}
		
		private function initGUI():void
		{
			
		}
		
		override public function onNetMSG(msg:NetMSG):void
		{
			switch(msg.code)
			{
				case 0:
					if(msg.msg && msg.msg.length > 0) trace(msg.msg);
					else trace(msg.dataEvent.data);
					break;
				default:
					trace('not sure how to handle this..');
			}
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