package app.game.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	/**
	 * 文件帮助类。
	 * 
	 * @author Zahoor Wang
	 * 
	 * @see www.9miao.com 9秒社团（游戏开源第一社区）
	 * @see firefly.9miao.com Firefly Game Server Framework
	 */
	public final class FileUtil
	{
		
		/**
		 * 同步方式读取一个文件，以 <code>ByteArray</code> 格式读取。
		 * <p><b>注：只能在AIR环境下使用。</b></p>
		 * 
		 * @param target 读取目标，可以是文件URL，也可以是文件 <code>File</code> 类型。
		 * 
		 * @return 返回读取目标的 <code>ByteArray</code> 内容，如果读取目标不可读，则返回 <code>null</code>。
		 */
		public static function reader(target:*):ByteArray
		{
			if (target is String || target is File)
			{
				var file:File = target is String ? new File(target) : (target as File).clone();
				if (file.exists && !file.isDirectory)
				{
					var bytes:ByteArray = new ByteArray();
					
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.READ);
					fs.readBytes(bytes, 0, fs.bytesAvailable);
					fs.close();
					fs = null;
					
					bytes.position = 0;
					
					file = null;
					return bytes;
				}
			}
			return null;
		}
		
		/**
		 * @private
		 * 
		 * Constructor.
		 */
		public function FileUtil()
		{
		}
		
	}
}