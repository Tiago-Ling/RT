package ;

class MovingSphere implements Hitable {
    public var center0:Vec3;
    public var center1:Vec3;
    public var time0:Float;
    public var time1:Float;
    public var radius:Float;
    public var material:Material;

    public function new(c0:Vec3, c1:Vec3, t0:Float, t1:Float, radius:Float, material:Material) {
        this.center0 = c0;
        this.center1 = c1;
        this.time0 = t0;
        this.time1 = t1;
        this.radius = radius;
        this.material = material;
    }

    public function hit(r:Ray, tMin:Float, tMax:Float):HitRecord {
        var oc:Vec3 = r.origin - center(r.time);
        var a:Float = Vec3.dot(r.direction, r.direction);
        var b:Float = Vec3.dot(oc, r.direction);
        var c:Float = Vec3.dot(oc, oc) - radius * radius;
        var discriminant:Float = b * b - a * c;
        var rec:HitRecord = null;
        if (discriminant > 0) {
            var temp:Float = (-b - Math.sqrt(b * b - a * c)) / a;
            if (temp < tMax && temp > tMin) {
                rec = new HitRecord();
                rec.t = temp;
                rec.p = r.pointAt(temp);
                rec.normal = (rec.p - center(r.time)) / radius;
                rec.matRef = material;
                return rec;
            }
            temp = (-b + Math.sqrt(b * b - a * c)) / a;
            if (temp < tMax && temp > tMin) {
                rec = new HitRecord();
                rec.t = temp;
                rec.p = r.pointAt(temp);
                rec.normal = (rec.p - center(r.time)) / radius;
                rec.matRef = material;
                return rec;
            }
        }
        return null;
    }

    public function center(time:Float):Vec3 {
        return center0 + (center1 - center0) * ((time - time0) / (time1 - time0));
    }
}