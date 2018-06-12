package;


import openfl.display.Sprite;


class Main extends Sprite {
	
	var nx:Int = 600;
	var ny:Int = 300;
	var ns:Int = 100;
	var camera:Camera;
	var world:HitableList;
	var data:openfl.display.BitmapData;

	public function new () {
		
		super ();

		data = new openfl.display.BitmapData(nx, ny, false, 0xFF000000);

		generateSpheres();
		// printTestImage();

		var bmp = new openfl.display.Bitmap(data);
		bmp.x = stage.stageWidth / 2 - nx / 2;
		bmp.y = stage.stageHeight / 2 - ny / 2;
		
		addChild(bmp);
		
	}

	function generateSpheres() {
		camera = new Camera();
		world = new HitableList();
		world.add(new Sphere(new Vec3(0, 0, -1), 0.5));
		world.add(new Sphere(new Vec3(0, -100.5, -1), 100));
		for (j in 0...ny) {
			var v = ny - j;
			for (i in 0...nx) {
				var col:Vec3 = new Vec3(0.0, 0.0, 0.0);
				for (s in 0...ns) {
					var u:Float = cast((i + Math.random()), Float) / cast(nx, Float);
					var v:Float = cast((v + Math.random()), Float) / cast(ny, Float);
					var r = camera.getRay(u, v);
					var p:Vec3 = r.pointAt(2.0);
					col += color(r, world);	
				}
				col /= cast(ns, Float);
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
	
	function color(r:Ray, world:Hitable):Vec3 {
		var rec:HitRecord = world.hit(r, 0.0, Math.POSITIVE_INFINITY);
		if (rec != null) {
			return new Vec3(rec.normal.x + 1.0, rec.normal.y + 1.0, rec.normal.z + 1.0) * 0.5;
		} else {
			var normalizedDir:Vec3 = Vec3.normalize(r.direction);
			var t:Float = (normalizedDir.y + 1.0) * 0.5;
			return new Vec3(1.0, 1.0, 1.0) * (1.0 - t) + new Vec3(0.5, 0.7, 1.0) * t;
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
}