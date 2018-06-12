package ;

interface Material {
    function scatter(inRay:Ray, rec:HitRecord, attenuation:Vec3, scattered:Ray):Bool;
}