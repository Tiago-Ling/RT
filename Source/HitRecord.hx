package ;

class HitRecord {
    public var t:Float;
    public var p:Vec3;
    public var normal:Vec3;

    public function new () {}

    public function copy():HitRecord {
        var hit = new HitRecord();
        hit.t = this.t;
        hit.p = this.p.copy();
        hit.normal = this.normal.copy();
        return hit;
    }

    public function toString():String {
        return 't : ' + Std.string(t) +
            '\np : ' + p.toString() +
            '\nnormal : ' + normal.toString();
    }
}