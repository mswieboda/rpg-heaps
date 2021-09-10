package rpg.game;

import hxt.obj.Obj;

import h3d.scene.Object;

class Space extends Object {
  var player : Player;
  var colliderObjs : Array<Obj>;
  var worldSize : Int;

  public var gateways : Map<String, Gateway>;

  public function new(
    player : Player,
    worldSize : Int,
    ?parent : Object
  ) {
    super(parent);

    this.player = player;
    this.worldSize = worldSize;
    this.gateways = new Map<String, Gateway>();

    colliderObjs = [];

    initPlane();
    initLights();
    initGateways();
    initColliderObjs();
  }

  function initPlane() {}

  function initLights() {}

  function initGateways() {}

  function initColliderObjs() {}

  public function update(dt : Float) {
    player.updateWithColliders(dt, colliderObjs);
  }
}
