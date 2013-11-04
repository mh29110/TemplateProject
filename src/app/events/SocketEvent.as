package app.game.events
{
	import flash.events.Event;
	
	import app.game.core.ClassFactory;
	
	public class SocketEvent extends Event
	{
		
		public static const RECONNECT:String = "reconnect";
		
		public static const WILLINGLY_DISCONNECT:String = "willinglyDisconnect";
		
		public static const UNWILLINGLY_DISCONNECT:String = "unwillinglyDisconnect";
		
		public function SocketEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		private var _reconnect:uint;
		
		public function get reconnect():uint
		{
			return _reconnect;
		}
		
		public function set reconnect(value:uint):void
		{
			if (value == _reconnect) return;
			_reconnect = value;
		}
		
		override public function clone():Event
		{
			return ClassFactory.apply(SocketEvent, [SocketEvent.RECONNECT], [{reconnect: reconnect}]);
		}
		
		override public function toString():String
		{
			return formatToString("SocketEvent", "type", "bubbles", "cancelable", "reconnect");
		}
		
	}
}