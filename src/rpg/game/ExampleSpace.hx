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
  var gateway : Gateway;

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
    var cube = new Cube(5, 15, 5, true);
    cube.addNormals();
    cube.addUVs();

    var model = new Mesh(cube);
    gateway = new Gateway(
      new Vector(0, 1, 0),
      model,
      new Vector(5, 15, 5),
      new Vector(5, 5, 5),
      this
    );
    gateway.trigger.x = 2.5;
    gateway.x = 50;
    gateway.y = 50;
    gateway.z = 2.5;

    gateways["ExampleTinySpace"] = gateway;

    // maybe add all gateways as colliderObjs at the end?
    // or no b/c maybe we want some gateway to not be collidable
    colliderObjs.push(gateway);

    // cave side top
    var side = new Cube(2.5, 2.5, 5, true);
    side.addNormals();
    side.addUVs();

    var obj;
    model = new Mesh(side, this);
    obj = new Obj(model, Collider.scaleSize(model, new Vector(0, 0, 0)), null, this);
    obj.x = gateway.x + 3.75;
    obj.y = gateway.y - 3.75;
    obj.z = gateway.z;
    colliderObjs.push(obj);

    // cave side bottom
    side = new Cube(2.5, 2.5, 5, true);
    side.addNormals();
    side.addUVs();

    model = new Mesh(side, this);
    obj = new Obj(model, Collider.scaleSize(model, new Vector(0, 0, 0)), null, this);
    obj.x = gateway.x + 3.75;
    obj.y = gateway.y + 3.75;
    obj.z = gateway.z;
    colliderObjs.push(obj);
  }

  override function initColliderObjs() {
    var cache = new ModelCache();
    var halfWorldSize = Std.int(worldSize / 2);

    for(i in 0...250) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);

      model.scale(1.2 + hxd.Math.srand(0.4));

      var obj = new Obj(model, Collider.scaleSize(model, new Vector(-1, -1, 0)), null, this);

      // NOTE: loop makes sure to place objs far enough away from gateway
      // (quick hack, not the great, doesn't take into account size, etc)
      do {
        obj.x = Math.random() * worldSize - halfWorldSize;
        obj.y = Math.random() * worldSize - halfWorldSize;
      } while (Math.abs(gateway.x - obj.x) < 10 && Math.abs(gateway.y - obj.y) < 10);

      colliderObjs.push(obj);
    }

    cache.dispose();
  }
}
