package rpg.game;

import rpg.obj.Obj;

import h3d.prim.Cube;
import h3d.mat.Texture;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Mesh;
import hxd.Res;

class Map extends Object {
  public var worldSize : Int;
  public var colliderObjs : Array<Obj>;

  public function new(
    worldSize: Int,
    ?parent: Object
  ) {
    super(parent);

    this.colliderObjs = [];
    this.worldSize = worldSize;

    initPlane();
    initColliderObjs();
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

  function initColliderObjs() {
    var cache = new ModelCache();
    var halfWorldSize = Std.int(worldSize / 2);

    for(i in 0...250) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);

      model.scale(1.2 + hxd.Math.srand(0.4));

      var obj = new Obj(model, { x: -2, y: -2, z: 0 }, null, this);

      obj.rotate(0, 0, hxd.Math.srand(Math.PI));
      obj.setPosition(
        Math.random() * worldSize - halfWorldSize,
        Math.random() * worldSize - halfWorldSize,
        0
      );

      colliderObjs.push(obj);
    }

    cache.dispose();
  }
}
