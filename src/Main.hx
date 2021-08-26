import h2d.Text;
import h3d.Vector;
import h3d.scene.CameraController;
import h3d.prim.Cube;
import h3d.scene.Object;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.App;
import hxd.Key;
import hxd.Res;
import hxd.System;
import hxd.res.DefaultFont;

class Main extends App {
  var map : WorldMap;
  var tf : Text;
  var player : Player;
  var cameraController : CameraController;

  static inline var PLAYER_SPEED = 10;
  static inline var CAMERA_DISTANCE = 64;
  static inline var CAMERA_INITIAL_THETA_DEGREES = 90;
  static inline var CAMERA_INITIAL_PHI_DEGREES = 60;

  override function init() {
    map = new WorldMap(16, 256, s3d);

    player = new Player(s3d);

    player.x = 64;
    player.y = 64;
    player.z = 0.99;

    // set initial camera
    cameraController = new CameraController(s3d);
    cameraController.loadFromCamera();
    cameraController.set(
      CAMERA_DISTANCE,
      hxd.Math.degToRad(CAMERA_INITIAL_THETA_DEGREES),
      hxd.Math.degToRad(CAMERA_INITIAL_PHI_DEGREES),
      new h3d.col.Point(64, 64, 0)
    );
    cameraController.toTarget();

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    tf = new Text(DefaultFont.get(), s2d);
  }

  override function update(dt: Float) {
    tf.text = 'player pos: [${player.x}, ${player.y}] drawCalls: ${engine.drawCalls}';

    updateCamera();
    player.update(dt);

    if(Key.isDown(Key.ESCAPE)) {
      System.exit();
    }
  }

  function updateCamera() {
    // if we want to follow the player use this:
    // cameraController.set(
    //   CAMERA_DISTANCE,
    //   hxd.Math.degToRad(CAMERA_INITIAL_THETA_DEGREES),
    //   hxd.Math.degToRad(CAMERA_INITIAL_PHI_DEGREES),
    //   new h3d.col.Point(player.x, player.y, 0)
    // );
    // if we want no transition, do it immediately:
    // cameraController.toTarget();
  }

  function updatePlayerMovement(dt: Float) {
    var dx = 0;
    var dy = 0;

    // move player left/right/up/down
    if(Key.isDown(Key.LEFT) || Key.isDown(Key.A)) {
      dx = -1;
    } else if (Key.isDown(Key.RIGHT) || Key.isDown(Key.D)) {
      dx = 1;
    }

    if(Key.isDown(Key.UP) || Key.isDown(Key.W)) {
      dy = -1;
    } else if (Key.isDown(Key.DOWN) || Key.isDown(Key.S)) {
      dy = 1;
    }

    if (dx == 0 && dy == 0) return;

    var adjusted_dx = dx / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
    var adjusted_dy = dy / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));

    player.x += dt * adjusted_dx * PLAYER_SPEED;
    player.y += dt * adjusted_dy * PLAYER_SPEED;

    player.setDirection(new Vector(-dy, dx, 0));
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
