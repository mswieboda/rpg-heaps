import h3d.prim.Cube;
import h3d.mat.Texture;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Mesh;
import h3d.scene.World;
import hxd.Res;

class WorldMap extends Object {
  var worldSize : Int;
  public var colliders : Array<Object>;

  public function new(
    worldSize: Int,
    ?parent: Object
  ) {
    super(parent);

    this.colliders = [];
    this.worldSize = worldSize;

    var cache = new ModelCache();
    var halfWorldSize = Std.int(worldSize / 2);

    for(i in 0...250) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);
      // var obj = new Obj(model, { x: -1, y: -1, z: -1 });
      var obj = new Obj(model, { x: 0, y: 0, z: 0 });
      var matrix = new h3d.Matrix();
      var scale = 1.2 + hxd.Math.srand(0.4);
      var rotation = hxd.Math.srand(Math.PI);

      matrix.initScale(scale, scale, scale);
      matrix.rotate(0, 0, rotation);
      matrix.translate(
        Math.random() * worldSize - halfWorldSize,
        Math.random() * worldSize - halfWorldSize,
        0
      );
      obj.setTransform(matrix);

      colliders.push(obj);
    }

    cache.dispose();

    for (collider in colliders) {
      addChild(collider);
    }

    initPlane();
  }

  function initPlane() {
    var halfWorldSize = Std.int(worldSize / 2);
    var tileSize = 4;
    var tiles = Std.int(worldSize / tileSize);

    var cube = new Cube(tileSize, tileSize, 0);
    cube.addNormals();
    cube.addUVs();

    for (x in 0...tiles) {
      for (y in 0...tiles) {
        var soil = new Mesh(cube, this);
        var yOddEven = x % 2 == 0 ? 1 : 0;
        var color = y % 2 == yOddEven ? 0x408020 : 0x204010;
        soil.material.texture = Texture.fromColor(color);
        soil.material.shadows = true;
        soil.x = x * tileSize - halfWorldSize;
        soil.y = y * tileSize - halfWorldSize;
      }
    }
  }
}
