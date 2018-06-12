package ; 

class Utils {
    public static function randomPointInUnitSphere():Vec3 {
		var p:Vec3 = null;
		do {
			p = new Vec3(Math.random(), Math.random(), Math.random()) * 2.0 - new Vec3(1.0, 1.0, 1.0);
		} while(p.lengthSquared >= 1.0);
		return p;
	}

    public static function printTestImage(data:openfl.display.BitmapData, nx:Int, ny:Int) {
		for (j in 0...ny) {
			var v = ny - j;
			for (i in 0...nx) {
				var col = new Vec3(
					i / nx,
					v / ny,
					0.2,
					0.0
				);
				var ir:Int = Math.floor(255.99 * col.x);
				var ig:Int = Math.floor(255.99 * col.y);
				var ib:Int = Math.floor(255.99 * col.z);
				data.setPixel32(i, j, rgbToHex(ir, ig, ib));
			}
		}
	}

    public static function rgbToHex(r, g, b, a = 255):UInt {
		return (a & 0xFF) << 24 | (r & 0xFF) << 16 | (g & 0xFF) << 8 | (b & 0xFF);
	}
}