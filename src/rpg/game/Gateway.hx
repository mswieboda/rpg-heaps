package rpg.game;

import rpg.game.Player;

import hxt.obj.Obj;

import h3d.Vector;
import h3d.scene.Object;

class Gateway extends Obj {
  // TODO: add direction to face
  // TODO: add player spawn x, y, z location
  // TODO: animate/move player out of gateway

  public function new(
    model : Object,
    ?colliderSize : Vector,
    ?triggerSize : Vector,
    ?parent : Object
  ) {
    super(model, colliderSize, triggerSize, parent);
  }
}
