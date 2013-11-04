package app.game.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import app.game.events.SocketEvent;
	
	[Event(name="reconnect", type="app.game.events.SocketEvent")]
	
	[Event(name="willinglyDisconnect", type="app.game.events.SocketEvent")]
	
	[Event(name="unwillinglyDisconnect", type="app.game.events.SocketEvent")]
	
	public class Socket extends flash.net.Socket
	{
		
		public function Socket(host:String = null, port:int = 0)
		{
			super(host, port);
			
			_host = host;
			_port = port;
		}
		
		private var attempts:uint = 0;
		
		private var disconnect:String = SocketEvent.UNWILLINGLY_DISCONNECT;
		
		private var _automatic:Boolean = false;
		
		public function get automatic():Boolean
		{
			return _automatic;
		}
		
		public function set automatic(value:Boolean):void
		{
			if (value == _automatic) return;
			_automatic = value;
		}
		
		private var _reconnect:uint = 0;
		
		public function get reconnect():uint
		{
			return _reconnect;
		}
		
		public function set reconnect(value:uint):void
		{
			if (value == _reconnect) return;
			_reconnect = value;
		}
		
		private var _host:String;
		
		public function get host():String
		{
			return _host;
		}
		
		private var _port:int;
		
		public function get port():int
		{
			return _port;
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, 
												  priority:int = 0, useWeakReference:Boolean = true):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			super.removeEventListener(type, listener, useCapture);
		}
		
		override public function close():void
		{
			disconnect = SocketEvent.WILLINGLY_DISCONNECT;
			if (connected) super.close();
		}
		
		override public function connect(host:String, port:int):void
		{
			_host = host;
			_port = port;
			configureListeners();
			super.connect(host, port);
		}
		
		override public function writeBoolean(value:Boolean):void
		{
			super.writeBoolean(value);
			if (automatic) flush();
		}
		
		override public function writeByte(value:int):void
		{
			super.writeByte(value);
			if (automatic) flush();
		}
		
		override public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void
		{
			super.writeBytes(bytes, offset, length);
			if (automatic) flush();
		}
		
		override public function writeDouble(value:Number):void
		{
			super.writeDouble(value);
			if (automatic) flush();
		}
		
		override public function writeFloat(value:Number):void
		{
			super.writeFloat(value);
			if (automatic) flush();
		}
		
		override public function writeInt(value:int):void
		{
			super.writeInt(value);
			if (automatic) flush();
		}
		
		override public function writeMultiByte(value:String, charSet:String):void
		{
			super.writeMultiByte(value, charSet);
			if (automatic) flush();
		}
		
		override public function writeObject(object:*):void
		{
			super.writeObject(object);
			if (automatic) flush();
		}
		
		override public function writeShort(value:int):void
		{
			super.writeShort(value);
			if (automatic) flush();
		}
		
		override public function writeUnsignedInt(value:uint):void
		{
			super.writeUnsignedInt(value);
			if (automatic) flush();
		}
		
		override public function writeUTF(value:String):void
		{
			super.writeUTF(value);
			if (automatic) flush();
		}
		
		override public function writeUTFBytes(value:String):void
		{
			super.writeUTFBytes(value);
			if (automatic) flush();
		}
		
		private function configureListeners():void
		{
			addEventListener(Event.CLOSE, close_handler, false, int.MAX_VALUE, true);
			addEventListener(Event.CONNECT, connect_handler, false, int.MAX_VALUE, true);
			addEventListener(IOErrorEvent.IO_ERROR, ioError_handler, false, int.MAX_VALUE, true);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError_handler, false, int.MAX_VALUE, true);
		}
		
		private function disposeListeners():void
		{
			removeEventListener(Event.CLOSE, close_handler, false);
			removeEventListener(Event.CONNECT, connect_handler, false);
			removeEventListener(IOErrorEvent.IO_ERROR, ioError_handler, false);
			removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError_handler, false);
		}
		
		private function close_handler(event:Event):void
		{
			disposeListeners();
			event.stopImmediatePropagation();
			
			dispatchEvent(new Event(Event.CLOSE));
			dispatchEvent(new SocketEvent(disconnect));
			disconnect = SocketEvent.UNWILLINGLY_DISCONNECT;
		}
		
		private function connect_handler(event:Event):void
		{
			attempts = 0;
		}
		
		private function ioError_handler(event:IOErrorEvent):void
		{
			if (attempts >= reconnect)
			{
				disposeListeners();
				attempts = 0;
				return;
			}
			
			event.stopImmediatePropagation();
		}
		
		private function securityError_handler(event:SecurityErrorEvent):void
		{
			if (attempts >= reconnect)
			{
				disposeListeners();
				attempts = 0;
				return;
			}
			
			event.stopImmediatePropagation();
			
			super.connect(host, port);
			dispatchEvent(ClassFactory.apply(SocketEvent, [SocketEvent.RECONNECT], [{reconnect: ++attempts}]));
		}
		
	}
}