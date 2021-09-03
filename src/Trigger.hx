import BoxMesh; // for Size

import h3d.mat.BlendMode;
import h3d.scene.Object;

class Trigger extends BoxMesh {
  public function new(size : Size, ?parent : Object) {
    super(size, parent);

    #if debug
    material.color.setColor(0x330000cc);
    material.blendMode = BlendMode.Alpha;
    material.shadows = false;
    #else
    visible = false;
    #end
  }

  public function triggered(obj : Object) : Bool {
    return obj.getBounds().collide(this.getBounds());
  }
}
