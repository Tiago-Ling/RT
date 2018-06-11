package;

class Ray {
    public var origin:Vec3;
    public var direction:Vec3;

    public function new (o:Vec3, d:Vec3) {
        origin = o;
        direction = d;
    }

    public function pointAt(t:Float):Vec3 {
        return origin + (direction * t);
    }
}