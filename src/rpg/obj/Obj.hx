package rpg.obj;

import rpg.obj.Collider; // for Scales
import rpg.obj.BoxMesh; // for Size

import h3d.mat.BlendMode;
import h3d.scene.Object;

class Obj extends Object {
  var collider : Collider;
  var trigger : Trigger;

  public function new(
    model : Object,
    ?colliderScales : Scales,
    ?triggerSize : Size,
    ?parent : Object
  ) {
    super(parent);

    addChild(model);

    if (colliderScales != null)
      collider = new Collider(model, colliderScales, this);

    if (triggerSize != null)
      trigger = new Trigger(triggerSize, this);
  }

  public function update(dt : Float) {}

  public function collided(obj : Object) : Bool {
    if (collider == null) return false;
    return collider.collided(obj);
  }

  public function triggered(obj : Object) : Bool {
    if (trigger == null) return false;
    return trigger.triggered(obj);
  }
}
