class Ray {
    public function new (o:Vec3, d:Vec3) {
        origin = o;
        direction = d;
    }

    @:keep
    public var origin(get, default):Vec3;
    function get_origin():Vec3 {
        return origin;
    }

    @:keep
    public var direction(get, default):Vec3;
    function get_direction():Vec3 {
        return direction;
    }

    public function pointAt(t:Float):Vec3 {
        return origin + t * direction;
    }
}