package ;

/**
 *  Diffuse (aka Lambertian) material
 */
class Lambertian implements Material {
    public var albedo:Vec3;

    public function new(a:Vec3) {
        albedo = a;
    }

    public function scatter(inRay:Ray, rec:HitRecord):ScatterRecord {
        var target:Vec3 = rec.p + rec.normal + Utils.randomPointInUnitSphere();
        var scatterRec = new ScatterRecord();
        scatterRec.scattered = new Ray(rec.p, target - rec.p);
        scatterRec.attenuation = albedo;
        return scatterRec;
    }
}