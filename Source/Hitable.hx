package ;

interface Hitable {
    function hit(r:Ray, tMin:Float, tMax:Float):HitRecord;
}