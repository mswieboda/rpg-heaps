package rpg.game;

import hxt.obj.Obj;

import h3d.scene.Object;

class Map extends Object {
  var player : Player;
  var camera : Camera;
  var colliderObjs : Array<Obj>;
  var worldSize : Int;

  public function new(
    player : Player,
    worldSize : Int,
    ?parent : Object
  ) {
    super(parent);

    this.player = player;
    this.worldSize = worldSize;

    camera = new Camera(player, parent);
    colliderObjs = [];

    initPlane();
    initLights();
    initColliderObjs();
  }

  function initPlane() {}

  function initLights() {}

  function initColliderObjs() {}

  public function update(dt : Float) {
    player.updateWithColliders(dt, colliderObjs);
    camera.update(dt);
  }
}
