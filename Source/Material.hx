package ;

interface Material {
    function scatter(inRay:Ray, rec:HitRecord):ScatterRecord;
}