import h3d.Vector;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class Player extends Object {
  var model : Object;

  static inline var PLAYER_SPEED = 10;

  public function new(parent: Object) {
    super(parent);

    var cache = new ModelCache();

    model = cache.loadModel(Res.player);

    cache.dispose();

    addChild(model);
  }

  public function update(dt: Float) {
    updatePlayerMovement(dt);
  }

  function updatePlayerMovement(dt: Float) {
    var dx = 0;
    var dy = 0;
    var dz = 0;

    if(Key.isDown(Key.LEFT) || Key.isDown(Key.A)) {
      dx = -1;
    } else if (Key.isDown(Key.RIGHT) || Key.isDown(Key.D)) {
      dx = 1;
    }

    if(Key.isDown(Key.UP) || Key.isDown(Key.W)) {
      dy = -1;
    } else if (Key.isDown(Key.DOWN) || Key.isDown(Key.S)) {
      dy = 1;
    }

    if (Key.isDown(Key.Q)) {
      dz = -1;
    } else if (Key.isDown(Key.E)) {
      dz = 1;
    }

    if (dx != 0 || dy != 0) {
      var adjusted_dx = dx / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
      var adjusted_dy = dy / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));

      x += dt * adjusted_dx * PLAYER_SPEED;
      y += dt * adjusted_dy * PLAYER_SPEED;

      setDirection(new Vector(-dy, dx, 0));
    }

    if (dz != 0) {
      z += dt * dz * PLAYER_SPEED;
    }
  }
}
