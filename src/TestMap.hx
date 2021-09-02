import h3d.prim.Cube;
import h3d.mat.Texture;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Mesh;
import h3d.scene.World;
import hxd.Res;

class TestMap extends Object {
  var worldSize : Int;
  public var colliderObjects : Array<Object>;

  public function new(
    worldSize: Int,
    ?parent: Object
  ) {
    super(parent);

    this.colliderObjects = [];
    this.worldSize = worldSize;

    initPlane();
  }

  function initPlane() {
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
        soil.x = x * tileSize;
        soil.y = y * tileSize;
      }
    }
  }
}
