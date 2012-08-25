package darklord
{
	/**
	 darklord.Engine
	 * Main game engine
	 * Uses FP for graphics/engine
	 * handles game state stack, core scene/view objects
	 * and passing render/update events through to current stack
	 * **/

	
	import darklord.net.NetMSG;
	import darklord.states.MenuState;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.flixel.FlxGame;
	
	public class Engine2D extends Sprite
	{
		private var states:Array = new Array();
		private var menu:MenuState;
		public var net:NetManager;
		
		public const gameWidth:int = 800;
		public const gameHeight:int = 600;

		public var fGame:FlxGame;
		
		public function Engine():void
		{
			this.mouseChildren = true;
			this.name = "game engine";
			trace(this.name);
			
		}
		
		//init- create scene/view and first game state stack
		public function init():void
		{
			this.net = new NetManager(this);
			this.net.connect();
			trace("stage"); 
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;
			
			
			initListeners();
			initState();
		}
		
		//load first menu state push it onto the stack
		private function initState():void
		{
			menu = new MenuState(this);
			menu.init();
			states.push(menu);
			
			//this.fGame = new FlxGame(gameWidth, gameHeight, MenuState);
			addChild(menu);
			//addChildAt(menu,1);
			
		}
			
		private function initListeners():void
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseDown);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		//run - enable game loop to run update/render
		public function run():void
		{
			
		}
		
		//pause - disable all update/render loops passing through to stack
		public function pause():void
		{
			
		}
		
		
		// INPUT HANDLERS //
		private function onMouseClick(ev:Event):void 
		{
			trace("Click!");
			if(states.length < 1) return;
			
			(states[0] as GameState2D).onMouseClick(ev);
		}
		private function onMouseUp(ev:Event):void 
		{
			if(states.length < 1) return;
			(states[0] as GameState2D).onMouseUp(ev);
		}
		private function onMouseDown(ev:Event):void 
		{
			if(states.length < 1) return;
			(states[0] as GameState2D).onMouseDown(ev);
		}
		
		private function onKeyDown(ev:Event):void 
		{
			if(states.length < 1) return;
			(states[0] as GameState2D).onKeyDown(ev);
		}
		private function onKeyUp(ev:Event):void 
		{
			if(states.length < 1) return;
			(states[0] as GameState2D).onKeyUp(ev);
		}
		
		//Network Events
		public function onNetConnect(ev:*):void
		{
			trace("connected to the server!");
			if(states.length < 1) return;
			(states[0] as GameState2D).onNetConnect(ev);
		}
		public function onNetMSG(ev:NetMSG):void
		{
			//trace(ev);
			if(states.length < 1) return;
			(states[0] as GameState2D).onNetMSG(ev);
		}
		public function onNetClose(ev:*):void
		{
			trace("Connection dropped");
			if(states.length < 1) return;
			(states[0] as GameState2D).onNetClose(ev);
		}
		public function onNetError(ev:*):void
		{
			trace("Network error!");
			trace(ev);
			if(states.length < 1) return;
			(states[0] as GameState2D).onNetError(ev);
		}
		
		
		//UPDATE->RENDER loop
		private function onEnterFrame(ev:Event):void 
		{
			if(states.length < 1) return; //no states on the stack
			var state = states[0]; //grab first state on the stack
			var currentState:GameState2D = state as GameState2D;
			
			currentState.update();
			currentState.render();
			
			
			
			//view.render();
		}
	}
}