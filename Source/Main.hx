package;


import openfl.display.Sprite;


class Main extends Sprite {
	
	var nx:Int = 300;
	var ny:Int = 150;
	var ns:Int = 100;
	var scale:Float = 2.0;
	var camera:Camera;
	var world:HitableList;
	var data:openfl.display.BitmapData;

	public function new () {
		
		super ();

		data = new openfl.display.BitmapData(nx, ny, false, 0xFF000000);

		generateSpheres();
		// printTestImage();

		var bmp = new openfl.display.Bitmap(data);
		bmp.scaleX = bmp.scaleY = scale;
		bmp.x = stage.stageWidth / 2 - (nx * scale) / 2;
		bmp.y = stage.stageHeight / 2 - (ny * scale) / 2;
		
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
				col = new Vec3(Math.sqrt(col.x), Math.sqrt(col.y), Math.sqrt(col.z)); //Gamma correction (1/2)
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
		var rec:HitRecord = world.hit(r, 0.001, Math.POSITIVE_INFINITY);
		if (rec != null) {
			var target:Vec3 = rec.p + rec.normal + randomPointInUnitSphere();
			return color(new Ray(rec.p, target - rec.p), world) * 0.5;
		} else {
			var normalizedDir:Vec3 = Vec3.normalize(r.direction);
			var t:Float = (normalizedDir.y + 1.0) * 0.5;
			return new Vec3(1.0, 1.0, 1.0) * (1.0 - t) + new Vec3(0.5, 0.7, 1.0) * t;
		}
	}

	function randomPointInUnitSphere():Vec3 {
		var p:Vec3 = null;
		do {
			p = new Vec3(Math.random(), Math.random(), Math.random()) * 2.0 - new Vec3(1.0, 1.0, 1.0);
		} while(p.lengthSquared >= 1.0);
		return p;
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