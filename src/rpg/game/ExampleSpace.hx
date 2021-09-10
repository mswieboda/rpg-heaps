package rpg.game;

import rpg.game.Gateway;

import hxt.obj.Collider;
import hxt.obj.Obj;

import h3d.Vector;
import h3d.mat.Texture;
import h3d.prim.Cube;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.fwd.DirLight;
import hxd.Res;

class ExampleSpace extends Space {
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
      new Vector(-1, 0, 0),
      model,
      null,
      new Vector(10, 10, 10),
      this
    );
    treeGateway.x = 50;
    treeGateway.y = 50;
    treeGateway.z = 0;

    gateways["ExampleTinySpace"] = treeGateway;

    // maybe add all gateways as colliderObjs at the end?
    // or no b/c maybe we want some gateway to not be collidable
    colliderObjs.push(treeGateway);
  }

  override function initColliderObjs() {
    var cache = new ModelCache();
    var halfWorldSize = Std.int(worldSize / 2);

    for(i in 0...250) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);

      model.scale(1.2 + hxd.Math.srand(0.4));

      var obj = new Obj(model, Collider.scaleSize(model, new Vector(-1, -1, 0)), null, this);
      obj.x = Math.random() * worldSize - halfWorldSize;
      obj.y = Math.random() * worldSize - halfWorldSize;

      colliderObjs.push(obj);
    }

    cache.dispose();
  }
}
