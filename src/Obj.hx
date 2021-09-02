import h3d.Vector;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class Obj extends Object {
  public function new(obj : Object, boundsScales : Scales) {
    super();

    // bounding box
    var bounds = obj.getBounds();
    var cube = new h3d.prim.Cube(
      bounds.xSize + obj.scaleX * boundsScales.x,
      bounds.ySize + obj.scaleY * boundsScales.y,
      bounds.zSize + obj.scaleZ * boundsScales.z,
      true
    );
    cube.addNormals();
    cube.addUVs();
    var collisionBox = new Mesh(cube, obj);

    // ignore original model bounds
    obj.ignoreBounds = true;
    addChild(obj);
  }

  public function update(dt : Float) {}
}

typedef Scales = {
  x : Float,
  y : Float,
  z : Float
}
