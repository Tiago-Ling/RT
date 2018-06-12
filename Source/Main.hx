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
		world.add(new Sphere(new Vec3(0, 0, -1), 0.5, new Lambertian(new Vec3(0.1, 0.2, 0.5))));
		world.add(new Sphere(new Vec3(0, -100.5, -1), 100, new Lambertian(new Vec3(0.8, 0.8, 0.0))));
		world.add(new Sphere(new Vec3(1, 0.0, -1), 0.5, new Metal(new Vec3(0.8, 0.6, 0.2), 0.3)));
		world.add(new Sphere(new Vec3(-1, 0.0, -1), 0.5, new Dieletric(1.5)));
		world.add(new Sphere(new Vec3(-1, 0.0, -1), -0.45, new Dieletric(1.5)));
		for (j in 0...ny) {
			var v = ny - j;
			for (i in 0...nx) {
				var col:Vec3 = new Vec3(0.0, 0.0, 0.0);
				for (s in 0...ns) {
					var u:Float = cast((i + Math.random()), Float) / cast(nx, Float);
					var v:Float = cast((v + Math.random()), Float) / cast(ny, Float);
					var r = camera.getRay(u, v);
					var p:Vec3 = r.pointAt(2.0);
					col += color(r, world, 0);	
				}
				col /= cast(ns, Float);
				col = new Vec3(Math.sqrt(col.x), Math.sqrt(col.y), Math.sqrt(col.z)); //Gamma correction (1/2)
				var ir:Int = Math.floor(255.99 * col.x);
				var ig:Int = Math.floor(255.99 * col.y);
				var ib:Int = Math.floor(255.99 * col.z);
				data.setPixel32(i, j, Utils.rgbToHex(ir, ig, ib));
			}
		}
	}
	
	function color(r:Ray, world:Hitable, depth:Int):Vec3 {
		var rec:HitRecord = world.hit(r, 0.001, Math.POSITIVE_INFINITY);
		if (rec != null) {
			var scatterRec:ScatterRecord = rec.matRef.scatter(r, rec);
			if (depth < 50 && scatterRec != null) {
				return Vec3.multVec(scatterRec.attenuation, color(scatterRec.scattered, world, depth + 1));
			} else {
				return new Vec3(0.0, 0.0, 0.0);
			}
		} else {
			var normalizedDir:Vec3 = Vec3.normalize(r.direction);
			var t:Float = (normalizedDir.y + 1.0) * 0.5;
			return new Vec3(1.0, 1.0, 1.0) * (1.0 - t) + new Vec3(0.5, 0.7, 1.0) * t;
		}
	}
}