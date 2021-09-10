package rpg.game;

import rpg.game.Gateway;

import hxt.obj.Collider;

import h3d.Vector;
import h3d.mat.Texture;
import h3d.prim.Cube;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.scene.fwd.DirLight;
import hxd.Res;

class ExampleTinySpace extends Space {
  public function new(
    player : Player,
    ?parent : Object
  ) {
    super(player, 32, parent);
  }

  override public function initPlane() {
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
        #if debug
        var color = y % 2 == yOddEven ? 0x408020 : 0x204010;
        #else
        var color = 0x408020;
        #end
        soil.material.texture = Texture.fromColor(color);
        soil.material.shadows = true;
        soil.x = x * tileSize - halfWorldSize;
        soil.y = y * tileSize - halfWorldSize;
      }
    }
  }

  override function initLights() {
    // add directional light
    new DirLight(new Vector(0.3, -0.4, -0.9), this);
  }

  override function initGateways() {
    var cache = new ModelCache();
    var model = cache.loadModel(Res.tree);
    cache.dispose();

    var treeGateway = new Gateway(
      new Vector(1, 0, 0),
      model,
      null,
      new Vector(10, 10, 10),
      this
    );
    treeGateway.x = 5;
    treeGateway.y = 10;

    gateways["ExampleSpace"] = treeGateway;

    // maybe add all gateways as colliderObjs at the end?
    // or no b/c maybe we want some gateway to not be collidable
    colliderObjs.push(treeGateway);
  }
}