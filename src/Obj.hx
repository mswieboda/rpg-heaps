import h3d.Vector;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class Obj extends Object {
  public function new(obj : Object, colliderDimensions : Dimension) {
    super();

    // bounding box
    var bounds = obj.getBounds();
    var cube = new h3d.prim.Cube(
      bounds.xSize * obj.scaleX + colliderDimensions.x,
      bounds.ySize * obj.scaleY + colliderDimensions.y,
      bounds.zSize * obj.scaleZ + colliderDimensions.z,
      true
    );
    cube.addNormals();
    cube.addUVs();
    var collisionBox = new Mesh(cube, this);
    collisionBox.x = obj.x;
    collisionBox.y = obj.y;
    collisionBox.z = obj.z;


    // ignore original model bounds
    obj.ignoreBounds = true;
    addChild(obj);

    // // bounding box
    // var sphere = new h3d.prim.Sphere(0.1);
    // sphere.translate(-0.05, -0.05, -0.05);
    // sphere.addNormals();
    // sphere.addUVs();
    // bounds = getBounds();
    // var mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMin;
    // mesh.y = bounds.yMin;
    // mesh.z = bounds.zMin;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMin;
    // mesh.y = bounds.yMax;
    // mesh.z = bounds.zMin;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMin;
    // mesh.y = bounds.yMin;
    // mesh.z = bounds.zMax;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMin;
    // mesh.y = bounds.yMax;
    // mesh.z = bounds.zMax;

    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMax;
    // mesh.y = bounds.yMin;
    // mesh.z = bounds.zMin;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMax;
    // mesh.y = bounds.yMax;
    // mesh.z = bounds.zMin;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMax;
    // mesh.y = bounds.yMin;
    // mesh.z = bounds.zMax;
    // mesh = new h3d.scene.Mesh(sphere, this);
    // mesh.ignoreBounds = true;
    // mesh.ignoreCollide = true;
    // mesh.x = bounds.xMax;
    // mesh.y = bounds.yMax;
    // mesh.z = bounds.zMax;
  }

  public function update(dt : Float) {}
}

typedef Dimension = {
  x : Float,
  y : Float,
  z : Float
}
