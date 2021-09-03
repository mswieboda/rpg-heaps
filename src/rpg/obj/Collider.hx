package rpg.obj;

import h3d.mat.BlendMode;
import h3d.scene.Object;

class Collider extends BoxMesh {
  public function new(model : Object, colliderScales : Scales, ?parent : Object) {
    var bounds = model.getBounds();
    var size = {
      x: bounds.xSize + model.scaleX * colliderScales.x,
      y: bounds.ySize + model.scaleY * colliderScales.y,
      z: bounds.zSize + model.scaleZ * colliderScales.z
    };

    super(size, parent);

    #if debug
    material.color.setColor(0x33cc0000);
    material.blendMode = BlendMode.Alpha;
    material.shadows = false;
    #else
    visible = false;
    #end
  }

  public function collided(obj : Object) : Bool {
    return obj.getBounds().collide(this.getBounds());
  }
}

typedef Scales = {
  x : Float,
  y : Float,
  z : Float
}
