package ;

class Camera {
	public var lowerLeftCorner:Vec3;
	public var horizontal:Vec3;
	public var vertical:Vec3;
	public var origin:Vec3;

    public function new() {
        lowerLeftCorner = new Vec3(-2.0, -1.0, -1.0);
        horizontal = new Vec3(4.0, 0.0, 0.0);
        vertical = new Vec3(0.0, 2.0, 0.0);
        origin = new Vec3(0.0, 0.0, 0.0);
    }

    public function getRay(u:Float, v:Float):Ray {
        return new Ray(origin, lowerLeftCorner + horizontal * u + vertical * v - origin);
    }
}