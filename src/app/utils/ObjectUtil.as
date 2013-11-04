package app.game.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Utilities for Object.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9
	 * @playerversion AIR 1.0
	 * 
	 * @author Zahoor Wang
	 */
	public final class ObjectUtil
	{
		
		public static function apply(object:*, properties:Array):*
		{
			if (!object) return null;
			
			var t:Object, a:Array = properties ? properties.concat() : [];
			while (a.length > 0)
			{
				t = a.shift();
				for (var k:* in t)
				{
					if (object.hasOwnProperty(k))
					{
						if (object[k] is Function) object[k].apply(null, t[k]);
						else object[k] = t[k];
					}
				}
			}
			return object;
		}
		
		
		/**
		 * This method is designed for cloning data objects, such as elements of a
		 * collection. It is not intended for cloning a display object.
		 * 
		 * @param o Object that should be cloned.
		 * 
		 * @return Clone of the specified object.
		 */
		public static function clone(o:*):*
		{
			var name:String = getQualifiedClassName(o);
			registerClassAlias(name.replace("::", "."), getDefinitionByName(name) as Class);
			
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(o);
			buffer.position = 0;
			return buffer.readObject();
		}
		
		
		public function ObjectUtil()
		{
		}
		
	}
}