package rpg.game;

import hxt.obj.Obj;

import h3d.scene.Object;

class Map extends Object {
  public var worldSize : Int;
  public var colliderObjs : Array<Obj>;

  public function new(
    worldSize: Int,
    ?parent: Object
  ) {
    super(parent);

    this.colliderObjs = [];
    this.worldSize = worldSize;

    initPlane();
    initColliderObjs();
  }

  function initPlane() {}

  function initColliderObjs() {}
}
