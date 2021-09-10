package rpg.game;

import rpg.game.Player;

import hxt.obj.Obj;

import h3d.Vector;
import h3d.scene.Object;

class Gateway extends Obj {
  public var active = true;

  var direction : Vector;

  public function new(
    direction : Vector,
    model : Object,
    ?colliderSize : Vector,
    ?triggerSize : Vector,
    ?parent : Object
  ) {
    super(model, colliderSize, triggerSize, parent);

    this.direction = direction;
  }

  public function movePlayerIn(dt : Float, player : Player) {
    var flippedDirection = direction.normalized().reflect(direction);

    player.active = false;

    // NOTE: y/-x on purpose for x/y b/c direction based on Quad
    player.move(dt, flippedDirection.y, -flippedDirection.x, 0);
  }

  // NOTE: doesn't take z into account
  public function readyToTeleport(player : Player) : Bool {
    var flippedDirection = direction.normalized().reflect(direction);

    // NOTE: y/-x on purpose for x/y b/c direction based on Quad
    var directionX = flippedDirection.y;
    var directionY = -flippedDirection.x;

    // start false, unless directions are both zero
    var ready = directionX == 0 && directionY == 0;

    if (directionX != 0) {
      ready = (directionX > 0 && player.x >= x) || (directionX < 0 && player.x <= x);
    }

    if (directionY != 0) {
      ready = (directionY > 0 && player.y >= y) || (directionY < 0 && player.y <= y);
    }

    return ready;
  }

  public function teleport(player : Player) {
    active = false;

    player.setDirection(direction);
    player.x = x;
    player.y = y;
  }

  public function movePlayerOut(dt : Float, player : Player) {
    if (!triggered(player)) return;

    var direction = direction.normalized();

    player.move(dt, direction.y, -direction.x, 0);

    if (!triggered(player)) {
      player.active = true;
      active = true;
    }
  }
}
