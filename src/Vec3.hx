abstract Vec3(Array<Float>) {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 0.0) {
        this[0] = x;
        this[1] = y;
        this[2] = z;
        this[3] = w;
    }

    @:op(A + B)
    public function add(other:Vec3):Vec3 {
        return new Vec3(
            this[0] + other.x,
            this[1] + other.y,
            this[2] + other.z,
            this[3] + other.w
        );
    }

    @:op(A - B)
    public function sub(other:Vec3):Vec3 {
        return new Vec3(
            this[0] - other.x,
            this[1] - other.y,
            this[2] - other.z,
            this[3] - other.w
        );
    }

    @:op(A * B) @:commutative
    public function mult(scalar:Float):Vec3 {
        return new Vec3(
            this[0] * scalar,
            this[1] * scalar,
            this[2] * scalar,
            this[3] * scalar
        );
    }

    @:op(A / B)
    public function divide(divisor:Float):Vec3 {
        return new Vec3(
            this[0] / divisor,
            this[1] / divisor,
            this[2] / divisor,
            this[3] / divisor
        );
    }

    @:keep
    public var x(get, set):Float;
    function get_x():Float {
        return this[0];
    }
    function set_x(v:Float):Float {
        return this[0] = v;
    }

    @:keep
    public var y(get, set):Float;
    function get_y():Float {
        return this[1];
    }
    function set_y(v:Float):Float {
        return this[1] = v;
    }

    @:keep
    public var z(get, set):Float;
    function get_z():Float {
        return this[2];
    }
    function set_z(v:Float):Float {
        return this[2] = v;
    }

    @:keep
    public var w(get, set):Float;
    function get_w():Float {
        return this[3];
    }
    function set_w(v:Float):Float {
        return this[3] = v;
    }
}