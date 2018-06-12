package ;

class Sphere implements Hitable {
    public var center:Vec3;
    public var radius:Float;

    public function new(center:Vec3, radius:Float) {
        this.center = center;
        this.radius = radius;
    }

    public function hit(r:Ray, tMin:Float, tMax:Float):HitRecord {
        var oc:Vec3 = r.origin - center;
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
                rec.normal = (rec.p - center) / radius;
                return rec;
            }
            temp = (-b + Math.sqrt(b * b - a * c)) / a;
            if (temp < tMax && temp > tMin) {
                rec = new HitRecord();
                rec.t = temp;
                rec.p = r.pointAt(temp);
                rec.normal = (rec.p - center) / radius;
                return rec;
            }
        }
        return null;
    }
}