import h3d.prim.Cube;
import h3d.mat.Texture;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Mesh;
import h3d.scene.World;
import hxd.Res;

class WorldMap extends Object {
  var worldSize : Int;
  public var colliderObjects : Array<Object>;

  public function new(
    worldSize: Int,
    ?parent: Object
  ) {
    super(parent);

    this.colliderObjects = [];
    this.worldSize = worldSize;

    var cache = new ModelCache();

    for(i in 0...500) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);
      var matrix = new h3d.Matrix();
      var scale = 1.2 + hxd.Math.srand(0.4);
      var rotation = hxd.Math.srand(Math.PI);

      matrix.initScale(scale, scale, scale);
      matrix.rotate(0, 0, rotation);
      matrix.translate(Math.random() * 128, Math.random() * 128, 0);
      model.setTransform(matrix);

      colliderObjects.push(model);
      addChild(model);
    }

    cache.dispose();

    initPlane();
  }

  function initPlane() {
    var cube = new Cube(worldSize, worldSize, 0);
    cube.addNormals();
    cube.addUVs();

    var soil = new Mesh(cube, this);
    soil.material.texture = Texture.fromColor(0x408020);
    soil.material.shadows = true;
  }
}
