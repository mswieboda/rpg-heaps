import h3d.Vector;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import hxd.Key;
import hxd.Res;

class PrimCube extends Object {
  var model : Mesh;
  var color : Int;

  static inline var PLAYER_SPEED = 10;
  static inline var COLLIDED_COLOR = 0xcc00cc;

  var collided = false;

  public function new(parent : Object, color : Int) {
    super(parent);

    this.color = color;

    var cube = new h3d.prim.Cube(3, 3, 3);
    cube.translate(-1.5, -1.5, -1.5);
    cube.addNormals();
    cube.addUVs();

    model = new Mesh(cube, parent);
    model.material.color.setColor(color);

    addChild(model);
  }

  public function update(dt : Float) {
    updateFromCollisions(dt);
    resetFromFrame();
  }

  function updateFromCollisions(dt : Float) {
    model.material.color.setColor(collided ? COLLIDED_COLOR : color);
  }

  function resetFromFrame() {
    collided = false;
  }

  public function onCollided(obj : Object) {
    collided = true;
  }
}
