import h3d.col.Point;
import h3d.scene.CameraController;
import h3d.scene.Object;

class Camera extends CameraController {
  static inline var CAMERA_FRICTION = 0.9;
  static inline var CAMERA_SMOOTH = 0.6;
  static inline var CAMERA_DISTANCE = 64;
  static inline var CAMERA_INITIAL_THETA_DEGREES = 90;
  static inline var CAMERA_INITIAL_PHI_DEGREES = 60;

  public function new(parent: Object) {
    super(parent);

    loadFromCamera();

    friction = CAMERA_FRICTION;
    smooth = CAMERA_SMOOTH;

    set(
      CAMERA_DISTANCE,
      hxd.Math.degToRad(CAMERA_INITIAL_THETA_DEGREES),
      hxd.Math.degToRad(CAMERA_INITIAL_PHI_DEGREES),
      new Point(64, 64, 0)
    );
    toTarget();
  }

  public function update(dt: Float, player: Object) {
    // if we want to follow the player use this:
    set(
      CAMERA_DISTANCE,
      hxd.Math.degToRad(CAMERA_INITIAL_THETA_DEGREES),
      hxd.Math.degToRad(CAMERA_INITIAL_PHI_DEGREES),
      new h3d.col.Point(player.x, player.y, 0)
    );
    // if we want no transition, do it immediately:
    // toTarget();
  }
}
