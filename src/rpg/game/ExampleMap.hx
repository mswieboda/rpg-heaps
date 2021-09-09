package rpg.game;

import hxt.obj.Collider;
import hxt.obj.Obj;

import h3d.Vector;
import h3d.mat.Texture;
import h3d.prim.Cube;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.fwd.DirLight;
import hxd.Res;

class ExampleMap extends Map {
  var treeTrigger : Obj;
  var treeTriggered = false;

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

  override function initColliderObjs() {
    var cache = new ModelCache();
    var halfWorldSize = Std.int(worldSize / 2);

    for(i in 0...250) {
      var model = Std.random(2) == 0 ? cache.loadModel(Res.tree) : cache.loadModel(Res.rock);

      model.scale(1.2 + hxd.Math.srand(0.4));

      var obj = new Obj(model, Collider.scaleSize(model, new Vector(-1, -1, 0)), null, this);

      // obj.rotate(0, 0, hxd.Math.srand(Math.PI));
      obj.setPosition(
        Math.random() * worldSize - halfWorldSize,
        Math.random() * worldSize - halfWorldSize,
        0
      );

      colliderObjs.push(obj);
    }

    // tree trigger
    var cache = new ModelCache();
    var model = cache.loadModel(Res.tree);
    cache.dispose();

    treeTrigger = new Obj(model, Collider.scaleSize(model, new Vector(-1.5, -1.5, 0)), new Vector(10, 10, 10), this);
    treeTrigger.x = 5;
    treeTrigger.y = 10;
    treeTrigger.z = 0;

    colliderObjs.push(treeTrigger);

    cache.dispose();
  }

  public override function update(dt : Float) {
    super.update(dt);

    if (treeTriggered) {
      treeTriggered = treeTrigger.triggered(player);

      if (!treeTriggered) {
        trace('>>> tree untriggered!', Date.now());
      }
    } else {
      treeTriggered = treeTrigger.triggered(player);

      if (treeTriggered) {
        trace('>>> tree triggered!', Date.now());
      }
    }
  }
}
