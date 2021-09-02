import h3d.Vector;
import h3d.col.Bounds;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class Player extends Obj {
  static inline var PLAYER_SPEED = 10;

  public function new(?parent : Object) {
    var cache = new ModelCache();
    var model = cache.loadModel(Res.player);
    cache.dispose();

    super(model, { x: -0.5, y: -0.5, z: 0 }, parent);
  }

  public function updateWithColliders(dt : Float, colliders : Array<Object>) {
    update(dt);
    updatePlayerMovement(dt, colliders);
  }

  function updatePlayerMovement(dt : Float, colliders : Array<Object>) {
    var dx = 0;
    var dx_actual = 0.0;
    var dy = 0;
    var dy_actual = 0.0;
    var dz = 0;
    var dz_actual = 0.0;
    var originalDirection = getLocalDirection();

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

      dx_actual = dt * adjusted_dx * PLAYER_SPEED;
      dy_actual = dt * adjusted_dy * PLAYER_SPEED;

      x += dx_actual;
      y += dy_actual;

      setDirection(new Vector(-dy, dx, 0));
    }

    if (dz != 0) {
      dz_actual = dt * dz * PLAYER_SPEED;

      z += dz_actual;
    }

    for (collider in colliders) {
      if (checkCollision(collider)) {
        x -= dx_actual;
        y -= dy_actual;
        z -= dz_actual;

        break;
      }
    }
  }

  function checkCollision(collider : Object) : Bool {
    return getBounds().collide(collider.getBounds());
  }
}
