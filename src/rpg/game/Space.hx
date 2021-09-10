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

  public function gatewayTeleport(dt : Float, from : String, to : String, toSpace : Space) : Bool {
    var gateway = gateways[to];
    var toGateway = toSpace.gateways[from];

    if (gateway == null || toGateway == null) return false;

    if (gateway.active) {
      if (gateway.triggered(player)) {
        // TODO: animate into the gateway, just like Gateway#movePlayer animates out of the Gateway
        toGateway.teleport(player);

        return true;
      }
    } else {
      gateway.movePlayer(dt, player);
    }

    return false;
  }
}
