package darklord.net
{
	import flash.events.DataEvent;

	/**
	 * darklord.net.NetMSG
	 * Holds message structure for messages back and forth from server to client
	 * contains the corresponding data event as well
	 * **/
	public class NetMSG
	{
		public var dataEvent:DataEvent;
		public var parsed:Boolean = false;
		public var code:Number =0;
		public var msg:String;
		
		public static const MSG_LOGGEDIN:uint = 1; 
		
		public function NetMSG(cd:Number=0,message:String=null,ev:DataEvent=null)
		{
			if(cd && message){ parsed=true; code = cd; msg = message; }
			if(ev) dataEvent = ev;
		}
	}
}