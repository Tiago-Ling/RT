package ;

class Camera {
	public var lowerLeftCorner:Vec3;
	public var horizontal:Vec3;
	public var vertical:Vec3;
	public var origin:Vec3;

    public function new(lookFrom:Vec3, lookAt:Vec3, vUp:Vec3, vfov:Float, aspect:Float) {
        var u, v, w:Vec3;
        var theta:Float = vfov * Math.PI / 180.0;
        var halfHeight:Float = Math.tan(theta / 2);
        var halfWidth:Float = aspect * halfHeight;
        origin = lookFrom;
        w = Vec3.normalize(lookFrom - lookAt);
        u = Vec3.normalize(Vec3.cross(vUp, w));
        v = Vec3.cross(w, u);
        lowerLeftCorner = new Vec3(-halfWidth, -halfHeight, -1.0);
        lowerLeftCorner = origin - u * halfWidth - v * halfHeight - w;
        horizontal = u * 2 * halfWidth;
        vertical = v * 2 * halfHeight;
    }

    public function getRay(u:Float, v:Float):Ray {
        return new Ray(origin, lowerLeftCorner + horizontal * u + vertical * v - origin);
    }
}