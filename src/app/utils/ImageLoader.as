package app.game.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 * 图片加载工具类。
	 * 
	 * @author Zahoor Wang
	 * 
	 * @see www.9miao.com 9秒社团（游戏开源第一社区）
	 * @see firefly.9miao.com Firefly Game Server Framework
	 */
	public final class ImageLoader
	{
		
		/**
		 * @private
		 */
		private static const EVENTS:Object = {
			"init": simple_hanlder,
			"open": simple_hanlder,
			"unload": simple_hanlder,
			"complete": simple_hanlder,
			"ioError": error_handler,
			"progress": progress_handler,
			"securityError": error_handler
		};
		
		/**
		 * 加载图片静态方法，自适应加载方式，自适应加载目标，可灵活扩展，可同步化加载过程。
		 * <p><b>注：沙箱安全需自行处理。</b></p>
		 * 
		 * @param target 要加载的东西，可以是一个URL字符串，或 <code>URLRequest</code> 对象，或 <code>ByteArray</code> 对象。
		 * @param callbacks 回调函数集，每一项的键为事件类型，值为事件的回调函数。事件支持以下：<br/>
		 * <table>
		 * 	<tr><th>事件类型</th><th>回调函数签名</th></tr>
		 * 	<tr><td><code>Event.INIT</code></td><td><code>init_handler(data:flash.display.Loader)</code></td></tr>
		 * 	<tr><td><code>Event.OPEN</code></td><td><code>open_handler(data:flash.display.Loader)</code></td></tr>
		 * 	<tr><td><code>Event.UNLOAD</code></td><td><code>unload_handler(data:flash.display.Loader)</code></td></tr>
		 * 	<tr><td><code>Event.COMPLETE</code></td><td><code>complete_handler(data:flash.display.Loader)</code></td></tr>
		 * 	<tr><td><code>IOErrorEvent.IO_ERROR</code></td><td><code>ioError_handler(message:String)</code></td></tr>
		 * 	<tr><td><code>ProgressEvent.PROGRESS</code></td><td><code>progress_handler(loaded:Number, total:Number)</code></td></tr>
		 * 	<tr><td><code>SecurityErrorEvent.SECURITY_ERROR</code></td><td><code>securityError_handler(message:String)</code></td></tr>
		 * </table>
		 * @param context <code>LoaderContext</code> 对象。
		 * 
		 * @return 返回加载图片时的 <code>flash.display.Loader</code> 对象。
		 * 
		 * @throws ArgumentError 当 <code>target</code> 不是URL字符串，或 <code>URLRequest</code>，
		 * 或 <code>ByteArray</code> 格式时抛出。
		 * 
		 * @see flash.display.Loader Loader
		 */
		public static function load(target:*, callbacks:Object = null, context:LoaderContext = null):Loader
		{
			if (!(target is String || target is URLRequest || target is ByteArray))
				throw new ArgumentError('The "target" must be URL String, or URLRequest object, or ByteArray object.');
			
			var loader:Loader = new Loader();
			
			for (var k:* in callbacks)
			{
				if (EVENTS.hasOwnProperty(k) && callbacks[k] is Function)
				{
					loader.contentLoaderInfo.addEventListener(k, 
						function(e:Event):void 
						{
							EVENTS[k](e, arguments.callee, callbacks[k]);
						}, 
						false, int.MIN_VALUE, true
					);
				}
			}
			
			if (target is ByteArray) loader.loadBytes(target, context);
			else loader.load(target is String ? new URLRequest(target) : target, context);
			
			return loader;
		}
		
		/**
		 * @private
		 */
		private static function simple_hanlder(event:Event, func:Function, callback:Function):void
		{
			event.target.removeEventListener(event.type, func);
			callback.call(null, event.target.loader);
		}
		
		/**
		 * @private
		 */
		private static function error_handler(event:Event, func:Function, callback:Function):void
		{
			event.target.removeEventListener(event.type, func);
			callback.call(null, event.toString());
		}
		
		/**
		 * @private
		 */
		private static function progress_handler(event:Event, func:Function, callback:Function):void
		{
			if (event["bytesLoaded"] >= event["bytesTotal"])
				event.target.removeEventListener(event.type, func);
			callback.call(null, event["bytesLoaded"], event["bytesTotal"]);
		}
		
		/**
		 * @private
		 * 
		 * Constructor.
		 */
		public function ImageLoader()
		{
		}
		
	}
}