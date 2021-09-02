import h3d.Vector;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class Collider extends Object {
  public function new(obj : Object) {
    super();

    addChild(obj);

    // bounding box
    var sphere = new h3d.prim.Sphere(0.1);
    sphere.translate(-0.05, -0.05, -0.05);
    sphere.addNormals();
    sphere.addUVs();
    var bounds = obj.getBounds();
    var mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMin;
    mesh.y = bounds.yMin;
    mesh.z = bounds.zMin;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMin;
    mesh.y = bounds.yMax;
    mesh.z = bounds.zMin;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMin;
    mesh.y = bounds.yMin;
    mesh.z = bounds.zMax;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMin;
    mesh.y = bounds.yMax;
    mesh.z = bounds.zMax;

    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMax;
    mesh.y = bounds.yMin;
    mesh.z = bounds.zMin;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMax;
    mesh.y = bounds.yMax;
    mesh.z = bounds.zMin;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMax;
    mesh.y = bounds.yMin;
    mesh.z = bounds.zMax;
    mesh = new h3d.scene.Mesh(sphere, this);
    mesh.ignoreBounds = true;
    mesh.ignoreCollide = true;
    mesh.x = bounds.xMax;
    mesh.y = bounds.yMax;
    mesh.z = bounds.zMax;
  }
}
