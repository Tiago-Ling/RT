package ;

class HitableList implements Hitable {
    var list:Array<Hitable>;
    public function new() {
        this.list = new Array<Hitable>();
    }

    public function add(h:Hitable) {
        list.push(h);
    }

    public var size(get, never):Int;
    function get_size():Int {
        return list.length;
    } 

    public function hit(r:Ray, tMin:Float, tMax:Float):HitRecord {
        var closestSoFar:Float = tMax;
        var rec:HitRecord = null;
        for (i in 0...list.length) {
            var tempRec = list[i].hit(r, tMin, closestSoFar);
            if (tempRec != null) {
                closestSoFar = tempRec.t;
                rec = tempRec;
            }
        }
        return rec;
    }
}