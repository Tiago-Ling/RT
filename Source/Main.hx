package;


import openfl.display.Sprite;


class Main extends Sprite {
	
	var nx:Int = 854;
	var ny:Int = 480;
	var ns:Int = 100;
	var scale:Float = 1.0;
	var camera:Camera;
	var world:HitableList;
	var data:openfl.display.BitmapData;

	public function new () {
		
		super ();

		data = new openfl.display.BitmapData(nx, ny, false, 0xFF000000);

		// generateSpheres();
		// printTestImage();
		randomScene();
		render();

		var bmp = new openfl.display.Bitmap(data);
		bmp.scaleX = bmp.scaleY = scale;
		bmp.x = stage.stageWidth / 2 - (nx * scale) / 2;
		bmp.y = stage.stageHeight / 2 - (ny * scale) / 2;
		
		addChild(bmp);
		
	}

	// function generateSpheres() {
	// 	var lookFrom = new Vec3(3, 3, 2);
	// 	var lookAt = new Vec3(0, 0, -1);
	// 	var distToFocus = (lookFrom - lookAt).length;
	// 	var aperture = 2.0;
	// 	camera = new Camera(lookFrom, lookAt, new Vec3(0, 1, 0), 20.0, cast(nx / ny, Float), aperture, distToFocus);
	// 	world = new HitableList();
	// 	world.add(new Sphere(new Vec3(0, 0, -1), 0.5, new Lambertian(new Vec3(0.1, 0.2, 0.5))));
	// 	world.add(new Sphere(new Vec3(0, -100.5, -1), 100, new Lambertian(new Vec3(0.8, 0.8, 0.0))));
	// 	world.add(new Sphere(new Vec3(1, 0.0, -1), 0.5, new Metal(new Vec3(0.8, 0.6, 0.2), 0.3)));
	// 	world.add(new Sphere(new Vec3(-1, 0.0, -1), 0.5, new Dieletric(1.5)));
	// 	world.add(new Sphere(new Vec3(-1, 0.0, -1), -0.45, new Dieletric(1.5)));
	// 	for (j in 0...ny) {
	// 		var v = ny - j;
	// 		for (i in 0...nx) {
	// 			var col:Vec3 = new Vec3(0.0, 0.0, 0.0);
	// 			for (s in 0...ns) {
	// 				var u:Float = cast((i + Math.random()), Float) / cast(nx, Float);
	// 				var v:Float = cast((v + Math.random()), Float) / cast(ny, Float);
	// 				var r = camera.getRay(u, v);
	// 				var p:Vec3 = r.pointAt(2.0);
	// 				col += color(r, world, 0);	
	// 			}
	// 			col /= cast(ns, Float);
	// 			col = new Vec3(Math.sqrt(col.x), Math.sqrt(col.y), Math.sqrt(col.z)); //Gamma correction (1/2)
	// 			var ir:Int = Math.floor(255.99 * col.x);
	// 			var ig:Int = Math.floor(255.99 * col.y);
	// 			var ib:Int = Math.floor(255.99 * col.z);
	// 			data.setPixel32(i, j, Utils.rgbToHex(ir, ig, ib));
	// 		}
	// 	}
	// }

	function render() {
		var lookFrom = new Vec3(13, 2, 3);
		var lookAt = new Vec3(0, 0, 0);
		var distToFocus = 10.0;
		var aperture = 0.0;
		camera = new Camera(lookFrom, lookAt, new Vec3(0, 1, 0), 20.0, cast(nx / ny, Float), aperture, distToFocus, 0.0, 1.0);
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

	function randomScene() {
		var n:Int = 50000;
		world = new HitableList();
		world.add(new Sphere(new Vec3(0, -1000, 0), 1000, new Lambertian(new Vec3(0.5, 0.5, 0.5))));
		var i:Int = 1;
		for (tA in 0...20) {
			var a = tA - 10;
			for (tB in 0...20) {
				var b = tB - 10;
				var chosen_mat = Math.random();
				var center = new Vec3(a + 0.9 * Math.random(), 0.2, b + 0.9 * Math.random());
				if ((center - new Vec3(4, 0.2, 0)).length > 0.9) {
					if (chosen_mat < 0.8) { //Diffuse
						var mat = new Lambertian(new Vec3(Math.random() * Math.random(), Math.random() * Math.random(), Math.random() * Math.random()));
						world.add(new MovingSphere(center, center + new Vec3(0, 0.5 + Math.random(), 0), 0.0, 1.0, 0.2, mat));
					} else if (chosen_mat < 0.95) { //Metal
						var metal = new Metal(new Vec3(0.5 * (1 + Math.random()), 0.5 * (1 + Math.random()), 0.5 * (1 + Math.random())), 0.5 * Math.random());
						world.add(new Sphere(center, 0.2, metal));
					} else { //Glass
						world.add(new Sphere(center, 0.2, new Dieletric(1.5)));
					}
				}
			}
		}

		world.add(new Sphere(new Vec3(0, 1, 0), 1.0, new Dieletric(1.5)));
		world.add(new Sphere(new Vec3(-4, 1, 0), 1.0, new Lambertian(new Vec3(0.4, 0.2, 0.1))));
		world.add(new Sphere(new Vec3(4, 1, 0), 1.0, new Metal(new Vec3(0.7, 0.6, 0.5), 0.0)));
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