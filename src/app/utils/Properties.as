package app.game.utils
{
	
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	import app.game.utils.ObjectUtil;
	
	/**
	 * The <code>Properties</code> class represents a persistent set of 
	 * properties. Each key and its corresponding value in the property list is 
	 * a string.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9
	 * @playerversion AIR 1.0 
	 * 
	 * @author Zahoor Wang
	 */
	public final class Properties
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Creates a new <code>Properties</code> instance.
		 * 
		 * @param content The content to be handle.
		 */
		public function Properties(content:* = null)
		{
			if (content is Properties)
			{
				props = ObjectUtil.clone((content as Properties).props) as Dictionary;
			}
			else
			{
				clear();
				from(content);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var props:Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Clears this <code>Properties</code> so that it contains no keys.
		 */
		public function clear():void
		{
			props = null;
			props = new Dictionary(true);
		}
		
		/**
		 * Creates a shallow copy of this instance object.
		 * 
		 * @return The new object. 
		 */
		public function clone():*
		{
			return ObjectUtil.clone(this) as Properties;
		}
		
		/**
		 * Concatenates the elements specified in the parameters with the 
		 * elements in an array.
		 * 
		 * @param rest A value of <code>Properties</code> type to be 
		 * concatenated in a new array.
		 * 
		 * @return The <code>Properties</code> itself object that contains the 
		 * elements from this array followed by elements from the parameters.
		 */
		public function concat(... rest):Properties
		{
			for each (var item:Properties in rest)
				for (var key:String in item.props)
					props[key] = item.props[key];
			return this;
		}
		
		/**
		 * Reads a property list from the input string content. The input data 
		 * uses the UTF-8 character encoding.
		 * 
		 * <p>The input data string using <code>\r\n</code> separated, ignored 
		 * empty lines, ignored the beginning of the "#" character line, and
		 * ignored no key line.</p>
		 * 
		 * @param content The content to be handle.
		 */
		public function from(content:String):void
		{
			if (!content) return;
			var items:Array = [], key:String = null, value:String = null;
			content = Capabilities.os.indexOf("Windows") == -1 ? content.replace(new RegExp("\n", "g"), "\r\n") : content;
			for each (var item:String in content.split("\r\n"))
			{
				item = StringUtil.trim(item);
				if (item.length == 0 || item.indexOf("#") == 0) continue;
				items = item.split("=");
				if (items.length > 1)
				{
					key = StringUtil.trim(items.shift() as String);
					value = StringUtil.trim(items.join(""));
					props[key] = value;
				}
			}
		}
		
		/**
		 * Searches for the property with the specified key in this property 
		 * list. The method returns the default value argument if the property 
		 * is not found.
		 * 
		 * @param key The specified key.
		 * @param defaultValue A default value.
		 * 
		 * @return The value in this property list with the specified key value.
		 */
		public function getProperty(key:String, defaultValue:String = null):String
		{
			return DictionaryUtil.get(props, key, defaultValue);
		}
		
		/**
		 * Tests if the specified object is a key in this property list.
		 * 
		 * @param key The possible key.
		 * 
		 * @return <code>true</code> if and only if the specified object is a 
		 * key in this property list; <code>false</code> otherwise.
		 */
		public function has(key:String):Boolean
		{
			return DictionaryUtil.has(props, key);
		}
		
		/**
		 * Tests if this property list no keys to values.
		 * 
		 * @return The property list no keys to values.
		 */
		public function isEmpty():Boolean
		{
			return DictionaryUtil.isEmpty(props);
		}
		
		/**
		 * Returns an array of the keys in this property list.
		 * 
		 * @return The array of the keys in this property list.
		 */
		public function keys():Array
		{
			return DictionaryUtil.keys(props);
		}
		
		/**
		 * Removes the key (and its corresponding value) from this property 
		 * list. This method nothing if the key is not in this property list.
		 * 
		 * @param key The key that needs to be removed.
		 * 
		 * @return The value to which the key had been mapped in this property 
		 * list, or <code>null</code> if the key dit not have a mapping.
		 */
		public function remove(key:String):String
		{
			return DictionaryUtil.remove(props, key);
		}
		
		/**
		 * Provides for parallelism with the <code>getProperty</code> method. 
		 * Enforces use of strings for property keys and values.
		 * 
		 * @param key The key to be placed into this property list.
		 * @param value The value corresponding to key.
		 * 
		 * @return The previous value of the specified key in this property 
		 * list, or <code>null</null> if it did not have one.
		 */
		public function setProperty(key:String, value:String):String
		{
			return DictionaryUtil.set(props, key, value);
		}
		
		/**
		 * Returns the number of keys in this property list.
		 * 
		 * @return The number of keys in this property list.
		 */
		public function size():int
		{
			return DictionaryUtil.size(props);
		}
		
		/**
		 * Returns an array of the values contained in this property list. The 
		 * collection is backed by the map, so changes to the map are reflected
		 * in the collection, and vice-versa. 
		 * 
		 * @return The values contained in this property list.
		 */
		public function values():Array
		{
			return DictionaryUtil.values(props);
		}
		
	}
}