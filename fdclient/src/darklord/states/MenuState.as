package darklord.states
{
	
	
	import darklord.Alert;
	import darklord.Engine2D;
	import darklord.GameState2D;
	import darklord.net.NetMSG;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.*;
	import flash.utils.*;
	
	public class MenuState extends GameState2D
	{
		
		
		private var userTXT:TextField = new TextField();
		private var passTXT:TextField = new TextField();
		private var googleBTN:TextField = new TextField();
		private var facebookBTN:TextField = new TextField();
		private var statusTXT:TextField = new TextField();
		
		public var status:String = "menu";
		private var alert:Alert;
		
		public function MenuState(engine:Engine2D)
		{
			super(engine);
		}
		
		override public function init():void
		{
			super.init();
			trace("Menu state initialized");
			
			var bgRect:Sprite = new Sprite();
			bgRect.name="bgRect";
			bgRect.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x440000], [1,1],[0,155]);
			bgRect.graphics.drawRect(0,0, this.eng.gameWidth, this.eng.gameHeight);
			this.addChild(bgRect);
			
			//var titleBMP:Bitmap = new TitleGFX(); titleBMP.alpha = 0.5;
			//bgRect.graphics.beginBitmapFill(titleBMP.bitmapData);
			//bgRect.graphics.drawRect(0,0, this.eng.gameWidth, this.eng.gameHeight);
			
			var titleText:TextField = new TextField();
			var titleFormat:TextFormat = new TextFormat("null",50,0xffffff,true);
			titleText.defaultTextFormat = titleFormat;
			titleText.text = "Dark Lord";
			titleText.width = 300;
			//titleText.textColor = 0xffffff;
			titleText.x = this.eng.gameWidth/2 - 100;
			titleText.y = this.eng.gameHeight/2 - 100;
			titleText.filters = [ new DropShadowFilter() ];
			this.addChild(titleText);
			
			
			var inputFormat:TextFormat = new TextFormat(null,20,0x000000,false,true,null);
			var btnFormat:TextFormat = new TextFormat(null,20,0xffffff,true,null,null,null,null,TextFormatAlign.CENTER);
			
			userTXT.defaultTextFormat = inputFormat;
			userTXT.text = "Enter Username";
			userTXT.width = 150;
			userTXT.height = 30;
			userTXT.background=true; userTXT.backgroundColor=0xffffff;
			userTXT.border=true; userTXT.borderColor=0xaaaaaa;
			userTXT.type = TextFieldType.INPUT;
			userTXT.x = eng.gameWidth/2 - userTXT.width/2; userTXT.y = titleText.y + 100;
			
			
			passTXT.defaultTextFormat = inputFormat;
			passTXT.text = "Enter Password";
			passTXT.width = 150;
			passTXT.height = 30;
			passTXT.background=true; passTXT.backgroundColor=0xffffff;
			passTXT.border=true; passTXT.borderColor=0xaaaaaa;
			passTXT.type = TextFieldType.INPUT;
			passTXT.x = eng.gameWidth/2 - passTXT.width/2; passTXT.y = userTXT.y + 50;
			
			userTXT.addEventListener(MouseEvent.CLICK,onInputClick);
			passTXT.addEventListener(MouseEvent.CLICK,onInputClick);
			
			var submitBTN:TextField = new TextField();
			submitBTN.defaultTextFormat = btnFormat;
			submitBTN.width = 220;
			submitBTN.background=true; submitBTN.backgroundColor=0x331111;
			submitBTN.border=true; submitBTN.borderColor=0xcccccc;
			submitBTN.text = "Login/Register"; submitBTN.height = 30; submitBTN.selectable = false;
			submitBTN.x = eng.gameWidth/2 - submitBTN.width/2; submitBTN.y = passTXT.y + 100;
			
			
			submitBTN.addEventListener(MouseEvent.CLICK,onSubmitClick);
			
			googleBTN.defaultTextFormat = btnFormat;
			facebookBTN.defaultTextFormat = btnFormat;
			
			googleBTN.background=true; googleBTN.backgroundColor=0x331111;
			googleBTN.border=true; googleBTN.borderColor=0xcccccc;
			googleBTN.text = "Login via Google";
			googleBTN.width = 180; googleBTN.height = 25;
			googleBTN.x = eng.gameWidth/2 - googleBTN.width - 20; googleBTN.y = titleText.y + 150;
			googleBTN.mouseEnabled = true;
			
			facebookBTN.background=true; facebookBTN.backgroundColor=0x331111;
			facebookBTN.border=true; facebookBTN.borderColor=0xcccccc;
			facebookBTN.text = "Login via Facebook";
			facebookBTN.width = 180; facebookBTN.height = 25;
			facebookBTN.x = eng.gameWidth/2 +20; facebookBTN.y = titleText.y + 150;
			facebookBTN.mouseEnabled = true;
			
			facebookBTN.addEventListener(MouseEvent.CLICK,onFacebookClick);
			googleBTN.addEventListener(MouseEvent.CLICK,onGoogleClick);
			
			this.addChild(userTXT); this.addChild(passTXT); this.addChild(submitBTN);
			//this.addChild(googleBTN); this.addChild(facebookBTN);
			
			statusTXT.textColor = 0xffffff;
			statusTXT.autoSize = flash.text.TextFieldAutoSize.CENTER;
			statusTXT.text = "Connecting to server..";
			statusTXT.x = eng.gameWidth/2 - statusTXT.width/2; statusTXT.y = submitBTN.y + 40;
			statusTXT.height = 20;
			statusTXT.addEventListener(MouseEvent.CLICK,onReconnect);
			this.addChild(statusTXT);
			
			
			this.alert = new Alert();
			this.addChild(alert);
		}
		
		//click on status txt to reconnect
		public function onReconnect(ev:MouseEvent):void
		{
			if(eng.net.isConnected) return;
			statusTXT.text = 'Reconnecting..';
			eng.net.connect();
		}
		
		public function onSubmitClick(ev:MouseEvent):void
		{
			if(status != "menu") return;
			if(!eng.net.isConnected){ alert.show("Not connected to the server!"); return; }
			if(userTXT.text=="Enter Username" || passTXT.text == "Enter Password"){
				alert.show("Please enter an existing username/password or create a new one");
				return;
			}
			if(userTXT.text.indexOf('~') > -1 || passTXT.text.indexOf("~") > -1){
				alert.show("Invalid character in password or username. Alphanumeric only");
				return;
			}
			this.status = "logging in";
			eng.net.userInfo['username'] = userTXT.text;
			eng.net.userInfo['password'] = passTXT.text;
			eng.net.sendData("1,"+userTXT.text+"~"+passTXT.text);
		}
		
		public function onGoogleClick(ev:MouseEvent):void
		{
			trace("google btn clicked");
			eng.net.loginGoogle();
			if(eng.net.isConnected){
				eng.net.sendData("1,Google button clicked");
			}
		}
		public function onFacebookClick(ev:MouseEvent):void
		{
			eng.net.loginFB();
		}
		
		public function onInputClick(ev:MouseEvent):void
		{
			var targ:TextField = ev.target as TextField;
			if(targ.text == "Enter Username" || targ.text == "Enter Password") targ.text = "";
		}
		
		override public function onMouseClick(ev:Event):void
		{
			//trace("click!");
			//trace( getQualifiedClassName(ev.target)  );
			if( "flash.display::Sprite" == getQualifiedClassName(ev.target) ){
				
				//trace((ev.target as Sprite).name);
			}
			
		}
		
		override public function update():void
		{
			
			super.update();
		}
		
		override public function render():void
		{
			
			super.render();
		}
		
		override public function onNetMSG(msg:NetMSG):void
		{
			//alert.show(msg.dataEvent.data);
			trace("msg code: "+msg.code+" : "+msg.msg);
			switch(msg.code)
			{
				case 0:
					if(msg.msg && msg.msg.length > 0) alert.show(msg.msg);
					else alert.show(msg.dataEvent.data);
					break;
				case NetMSG.MSG_LOGGEDIN:
					statusTXT.text = "Logged in as "+eng.net.userInfo['username'];
					break;
				default:
					trace('not sure how to handle this..');
			}
			
			//trace("Menu received net msg"); trace(ev);
		}
		override public function onNetClose(ev):void
		{
			alert.show("Connection to server dropped!");
			statusTXT.text = "Connection dropped. Click to reconnect";
		}
		override public function onNetError(ev):void
		{
			alert.show("Network Error!");
		}
		override public function onNetConnect(ev):void
		{
			statusTXT.text = "Connected to server!";
			if(eng.net.userInfo['username']){
				//username already set - send login
				eng.net.sendData("1,"+eng.net.userInfo['username']+"~"+eng.net.userInfo['password']);
			}
			else { trace("user info not set"); trace(eng.net.userInfo); }
		}
	}
}