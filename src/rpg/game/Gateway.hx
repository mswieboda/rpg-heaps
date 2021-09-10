package rpg.game;

import rpg.game.Player;

import hxt.obj.Obj;

import h3d.Vector;
import h3d.scene.Object;

class Gateway extends Obj {
  public var active = true;
  var direction : Vector;

  // TODO: animate/move player out of gateway

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

  public function teleport(player : Player) {
    active = false;

    player.active = false;
    player.setDirection(direction);
    player.x = x;
    player.y = y;
  }

  // TODO: animate into the gateway, just like Gateway#movePlayer animates out of the Gateway
  //       and rename movePlayer to animatePlayerOut etc?
  public function movePlayer(dt : Float, player : Player) {
    if (!triggered(player)) return;

    var direction = direction.normalized();

    player.move(dt, direction.y, -direction.x, 0);

    if (!triggered(player)) {
      player.active = true;
      active = true;
    }
  }
}
