package ;

/**
 *  Diffuse (aka Lambertian) material
 */
class Lambertian implements Material {
    public var albedo:Vec3;

    public function new(a:Vec3) {
        albedo = a;
    }

    public function scatter(inRay:Ray, rec:HitRecord, attenuation:Vec3, scattered:Ray):Bool {
        var target:Vec3 = rec.p + rec.normal + Utils.randomPointInUnitSphere();
        scattered = new Ray(rec.p, target - rec.p);
        attenuation = albedo;
        return true;
    }
}