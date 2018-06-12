package ;

class Metal implements Material {
    public var albedo:Vec3;

    public function new(a:Vec3) {
        albedo = a;
    }

    public function scatter(inRay:Ray, rec:HitRecord):ScatterRecord {
        var reflected:Vec3 = Vec3.reflect(Vec3.normalize(inRay.direction), rec.normal);
        var scatterRec = new ScatterRecord();
        scatterRec.scattered = new Ray(rec.p, reflected);
        scatterRec.attenuation = albedo;
        if (Vec3.dot(scatterRec.scattered.direction, rec.normal) > 0.0)
            return scatterRec;

        return null;
    }
}