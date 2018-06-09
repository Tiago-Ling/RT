package;


import openfl.display.Sprite;


class Main extends Sprite {
	
	var nx:Int = 600;
	var ny:Int = 300;
	var data:openfl.display.BitmapData;

	public function new () {
		
		super ();

		data = new openfl.display.BitmapData(nx, ny, false, 0xFF000000);

		generateBackground();
		// printTestImage();

		var bmp = new openfl.display.Bitmap(data);
		bmp.x = stage.stageWidth / 2 - nx / 2;
		bmp.y = stage.stageHeight / 2 - ny / 2;
		
		addChild(bmp);
		
	}

	function generateBackground() {
		var lowerLeftCorner:Vec3 = new Vec3(-2.0, -1.0, -1.0);
		var horizontal:Vec3 = new Vec3(4.0, 0.0, 0.0);
		var vertical:Vec3 = new Vec3(0.0, 2.0, 0.0);
		var origin:Vec3 = new Vec3(0.0, 0.0, 0.0);

		for (j in 0...ny) {
			var v = ny - j;
			for (i in 0...nx) {
				var u:Float = cast(i, Float) / cast(nx, Float);
				var v:Float = cast(v, Float) / cast(ny, Float);
				var r = new Ray(origin, lowerLeftCorner + horizontal * u + vertical * v);
				var col = color(r);
				var ir:Int = Math.floor(255.99 * col.x);
				var ig:Int = Math.floor(255.99 * col.y);
				var ib:Int = Math.floor(255.99 * col.z);
				data.setPixel32(i, j, rgbToHex(ir, ig, ib));
			}
		}
	}

	function printTestImage() {
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

	function rgbToHex(r, g, b, a = 255):UInt {
		return (a & 0xFF) << 24 | (r & 0xFF) << 16 | (g & 0xFF) << 8 | (b & 0xFF);
	}
	
	function color(r:Ray):Vec3 {
		var t:Float = hitSphere(new Vec3(0, 0, -1), 0.5, r);
		if (t > 0.0) {
			var N:Vec3 = Vec3.normalize(r.pointAt(t) - new Vec3(0, 0, -1));
			return new Vec3(N.x + 1, N.y + 1, N.z + 1) * 0.5;
		}

		var normalizedDir = Vec3.normalize(r.direction);
		var t:Float = 0.5 * (normalizedDir.y + 1.0);
		return new Vec3(1.0, 1.0, 1.0) * (1.0 - t) + new Vec3(0.5, 0.7, 1.0) * t;
	}

	function hitSphere(center:Vec3, radius:Float, r:Ray):Float {
		var oc:Vec3 = r.origin - center;
		var a:Float = Vec3.dot(r.direction, r.direction);
		var b:Float = Vec3.dot(oc, r.direction) * 2.0;
		var c:Float = Vec3.dot(oc, oc) - radius * radius;
		var discriminant:Float = b * b - 4 * a * c;
		if (discriminant < 0) {
			return -1.0;
		} else {
			return (-b - Math.sqrt(discriminant)) / (2.0 * a);
		}
	}
}