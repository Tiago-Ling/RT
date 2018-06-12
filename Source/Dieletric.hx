package ;

/**
 *  Glass, water, diamond material
 */
class Dieletric implements Material {
    var refIdx:Float;
    public function new(ri:Float) {
        refIdx = ri;
    }

    public function scatter(inRay:Ray, rec:HitRecord):ScatterRecord {
        var outwardNormal:Vec3 = null;
        var reflected:Vec3 = Vec3.reflect(inRay.direction, rec.normal);
        var niOverNt:Float = 0;
        var attenuation:Vec3 = new Vec3(1.0, 1.0, 1.0);
        var refracted:Vec3 = null;
        var reflectProb:Float = 0;
        var cosine:Float = 0;
        if (Vec3.dot(inRay.direction, rec.normal) > 0.0) {
            outwardNormal = rec.normal * -1;
            niOverNt = refIdx;
            cosine = refIdx * Vec3.dot(inRay.direction, rec.normal) / inRay.direction.length;
        } else {
            outwardNormal = rec.normal;
            niOverNt = 1.0 / refIdx;
            cosine = -Vec3.dot(inRay.direction, rec.normal) / inRay.direction.length;
        }

        refracted = refract(inRay.direction, outwardNormal, niOverNt);
        var scattered:Ray = null;
        if (refracted != null) {
            reflectProb = schlick(cosine, refIdx);
        } else {
            reflectProb = 1.0;
        }
        if (Math.random() < reflectProb) {
            scattered = new Ray(rec.p, reflected);
        } else {
            scattered = new Ray(rec.p, refracted);
        }
        
        var scatterRec = new ScatterRecord();
        scatterRec.attenuation = attenuation;
        scatterRec.scattered = scattered;
        return scatterRec;
    }

    function refract(v:Vec3, n:Vec3, niOverNt:Float):Vec3 {
        var uv = Vec3.normalize(v);
        var dt:Float = Vec3.dot(uv, n);
        var discriminant:Float = 1.0 - niOverNt * niOverNt * (1 - dt * dt);
        if (discriminant > 0.0) {
            return (uv - n * dt) * niOverNt - n * Math.sqrt(discriminant);
        }
        return null;
    }

    function schlick(cosine:Float, rIdx:Float):Float {
        var r0:Float = (1 - rIdx) / (1 + rIdx);
        r0 = r0 * r0;
        return r0 + (1 - r0) * Math.pow((1 - cosine), 5);
    }
}