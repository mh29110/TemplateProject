package app.game.utils
{
	
	import flash.utils.Dictionary;
	
	/**
	 * Utilities for Dictionary.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9
	 * @playerversion AIR 1.0
	 * 
	 * @author Zahoor Wang
	 */
	public final class DictionaryUtil extends Object
	{
		
		public static function get(dict:Dictionary, key:*, defaultValue:* = null):*
		{
			if (dict)
			{
				var rst:* = has(dict, key) ? dict[key] : null;
				!rst && (rst = defaultValue);
				return rst;
			}
			return null;
		}
		
		public static function has(dict:Dictionary, key:*):Boolean
		{
			return dict && dict.hasOwnProperty(key);
		}
		
		public static function isEmpty(dict:Dictionary):Boolean
		{
			return keys(dict).length == 0;
		}
		
		public static function keys(dict:Dictionary):Array
		{
			if (!dict) return [];
			
			var rst:Array = [];
			for (var key:* in dict) rst.push(key);
			return rst;
		}
		
		public static function remove(dict:Dictionary, key:*):*
		{
			if (dict)
			{
				var rst:* = has(dict, key) ? get(dict, key) : null;
				delete dict[key];
				return rst;
			}
			return null;
		}
		
		public static function set(dict:Dictionary, key:*, value:*):*
		{
			if (dict)
			{
				var rst:* = has(dict, key) ? get(dict, key) : null;
				dict[key] = value;
				return rst;
			}
			return null;
		}
		
		public static function size(dict:Dictionary):int
		{
			return keys(dict).length;
		}
		
		public static function values(dict:Dictionary):Array
		{
			if (!dict) return [];
			
			var rst:Array = [];
			for each (var value:* in dict) rst.push(value);
			return rst;
		}
		
		
		public function DictionaryUtil()
		{
		}
		
	}
	
}