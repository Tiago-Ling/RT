package ;

class Metal implements Material {
    public var albedo:Vec3;

    public function new(a:Vec3) {
        albedo = a;
    }

    public function scatter(inRay:Ray, rec:HitRecord, attenuation:Vec3, scattered:Ray):Bool {
        var reflected:Vec3 = Vec3.reflect(Vec3.normalize(inRay.direction), rec.normal);
        scattered = new Ray(rec.p, reflected);
        attenuation = albedo;
        return (Vec3.dot(scattered.direction, rec.normal) > 0.0);
    }
}