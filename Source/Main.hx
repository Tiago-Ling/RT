package;


import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();

		var nx:Int = 200;
		var ny:Int = 100;
		var data = new openfl.display.BitmapData(nx, ny, false, 0xFF000000);
		
		var j:Int = ny - 1;
		while (j >= 0) {
			for (i in 0...nx) {
				var r:Float = cast(i, Float) / cast(nx, Float);
				var g:Float = cast(j, Float) / cast(ny, Float);
				var b:Float = 0.2;
				var ir:Int = Std.int(255.99 * r);
				var ig:Int = Std.int(255.99 * g);
				var ib:Int = Std.int(255.99 * b);
				data.setPixel32(i, j, rgbToHex(ir, ig, ib));
			}
			j--;
		}

		var bmp = new openfl.display.Bitmap(data);
		addChild(bmp);
		
	}

	function rgbToHex(r, g, b, a = 255):UInt {
		return (a & 0xFF) << 24 | (r & 0xFF) << 16 | (g & 0xFF) << 8 | (b & 0xFF);
	}
	
	
}