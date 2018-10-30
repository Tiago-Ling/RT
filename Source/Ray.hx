package;

class Ray {
    public var origin:Vec3;
    public var direction:Vec3;
    public var time:Float;

    public function new (o:Vec3, d:Vec3, ti:Float = 0) {
        origin = o;
        direction = d;
        time = ti;
    }

    public function pointAt(t:Float):Vec3 {
        return origin + (direction * t);
    }
}