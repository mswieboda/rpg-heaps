package rpg.game;

import hxt.obj.Collider;
import hxt.obj.Obj;

import h3d.Vector;
import h3d.prim.ModelCache;
import hxd.Res;

class ExampleMap extends Map {
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

    cache.dispose();
  }
}
