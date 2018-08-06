package ;

class Camera {
	public var lowerLeftCorner:Vec3;
	public var horizontal:Vec3;
	public var vertical:Vec3;
	public var origin:Vec3;
    public var u:Vec3;
    public var v:Vec3;
    public var w:Vec3;
    public var lens_radius:Float;

    public function new(lookFrom:Vec3, lookAt:Vec3, vUp:Vec3, vfov:Float, aspect:Float, aperture:Float, focusDist:Float) {
        lens_radius = aperture / 2;
        var theta:Float = vfov * Math.PI / 180.0;
        var halfHeight:Float = Math.tan(theta / 2);
        var halfWidth:Float = aspect * halfHeight;
        origin = lookFrom;
        w = Vec3.normalize(lookFrom - lookAt);
        u = Vec3.normalize(Vec3.cross(vUp, w));
        v = Vec3.cross(w, u);
        lowerLeftCorner = origin - u * focusDist * halfWidth - v * focusDist * halfHeight - w * focusDist;
        horizontal = u * focusDist * 2 * halfWidth;
        vertical = v * focusDist * 2 * halfHeight;
    }

    public function getRay(s:Float, t:Float):Ray {
        var rd:Vec3 = randomPointInUnitDisk() * lens_radius;
        var offset:Vec3 = (u * rd.x)  + (v * rd.y);
        return new Ray(origin + offset, lowerLeftCorner + horizontal * s + vertical * t - origin - offset);
    }

    function randomPointInUnitDisk():Vec3 {
		var p:Vec3 = null;
		do {
			p = new Vec3(Math.random(), Math.random(), 0.0) * 2.0 - new Vec3(1.0, 1.0, 0.0);
		} while(Vec3.dot(p, p) >= 1.0);
		return p;
	}
}