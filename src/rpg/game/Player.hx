package rpg.game;

import hxt.input.Input;
import hxt.obj.Obj;

import h3d.Vector;
import h3d.col.Bounds;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import hxd.Res;
import hxd.res.Sound;
import hxd.snd.Channel;

class Player extends Obj {
  public static inline var PLAYER_SPEED = 10;

  public var active = true;

  var moved = false;

  var soundBump : Sound;
  var soundChannelBump : Channel;
  var soundBumpObj : Obj;

  public function new(?parent : Object) {
    var cache = new ModelCache();
    var model = cache.loadModel(Res.player);
    cache.dispose();

    super(model, new Vector(1, 1, 2), null, parent);

    soundBump = if (hxd.res.Sound.supportedFormat(Wav)) hxd.Res.bump else null;
  }

  public function updateWithColliders(dt : Float, objs : Array<Obj>) {
    update(dt);
    updatePlayerMovement(dt, objs);
  }

  public function move(dt : Float, dx : Float, dy : Float, dz : Float) {
    if (dx != 0 || dy != 0) {
      var adjusted_dx = dx / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
      var adjusted_dy = dy / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));

      var dx_actual = dt * adjusted_dx * PLAYER_SPEED;
      var dy_actual = dt * adjusted_dy * PLAYER_SPEED;

      x += dx_actual;
      y += dy_actual;

      setDirection(new Vector(-dy, dx, 0));
    }

    if (dz != 0) {
      var dz_actual = dt * dz * PLAYER_SPEED;

      z += dz_actual;
    }
  }

  function updatePlayerMovement(dt : Float, objs : Array<Obj>) {
    if (!active) return;

    var dx = 0;
    var dx_actual = 0.0;
    var dy = 0;
    var dy_actual = 0.0;
    var dz = 0;
    var dz_actual = 0.0;
    var originalDirection = getLocalDirection();
    var tryingToMove = false;

    if(Input.game.isDown("moveLeft")) {
      dx = -1;
    } else if (Input.game.isDown("moveRight")) {
      dx = 1;
    }

    if(Input.game.isDown("moveForward")) {
      dy = -1;
    } else if (Input.game.isDown("moveBackward")) {
      dy = 1;
    }

    if (Input.game.isDown("moveUp")) {
      dz = -1;
    } else if (Input.game.isDown("moveDown")) {
      dz = 1;
    }

    // TODO: refactor this to use #move(dt, dx, dy, dz) and return dx_actual, dy_actual, dz_actual in case of collision
    //       and maybe use Vector as arg instead of dx, dy, dz, and return Vector
    if (dx != 0 || dy != 0) {
      var adjusted_dx = dx / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
      var adjusted_dy = dy / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));

      dx_actual = dt * adjusted_dx * PLAYER_SPEED;
      dy_actual = dt * adjusted_dy * PLAYER_SPEED;

      x += dx_actual;
      y += dy_actual;

      tryingToMove = true;

      setDirection(new Vector(-dy, dx, 0));
    }

    if (dz != 0) {
      dz_actual = dt * dz * PLAYER_SPEED;

      z += dz_actual;
    }

    var collided = false;

    for (obj in objs) {
      if (obj.collided(this)) {
        x -= dx_actual;
        y -= dy_actual;
        z -= dz_actual;

        if (moved && (soundChannelBump == null || soundChannelBump.isReleased())) {
          soundChannelBump = soundBump.play();
          soundBumpObj = obj;
        }

        collided = true;

        break;
      }
    }

    moved = tryingToMove && !collided;
  }
}
