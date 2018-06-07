abstract Vec3(Array<Float>) {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 0.0) {
        this[0] = x;
        this[1] = y;
        this[2] = z;
        this[3] = w;
    }

    public function set(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 0.0):Vec3 {
        this[0] = x;
        this[1] = y;
        this[2] = z;
        this[3] = w;
        return this;
    }

    public function dot(other:Vec3):Float {
        return this[0] * other.x + this[1] * other.y + this[2] * other.z;
    }

    public function cross(other:Vec3):Vec3 {
        return new Vec3(this[1] * other.z - this[2] * other.y, this[2] * other.x - this[0] * other.z, this[0] * other.y - this[1] * other.x, 1);
    }

    public function normalize():Vec3 {
        return this / this.length;
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

    @:op(A += B)
    public function addAssign(other:Vec3):Vec3 {
        return this + other;
    }

    @:op(A -= B)
    public function subAssign(other:Vec3):Vec3 {
        return this - other;
    }

    @:op(A *= B)
    public function multAssign(scalar:Float):Vec3 {
        return this * scalar;
    }
    
    @:op(A /= B)
    public function divAssign(divisor:Float):Vec3 {
        return this / divisor;
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

    @:keep
    public var length(get, never):Float;
    function get_length():Float {
        return Math.sqrt(this[0] * this[0] + this[1] * this[1] + this[2] * this[2]);
    }

    @:keep
    public var lengthSquared(get, never):Float;
    function get_lengthSquared():Float {
        return this[0] * this[0] + this[1] * this[1] + this[2] * this[2];
    }
}