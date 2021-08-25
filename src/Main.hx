import h2d.Text;
import h3d.Vector;
import h3d.scene.CameraController;
import h3d.prim.Cube;
import h3d.scene.Object;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.Key;
import hxd.Res;
import hxd.System;
import hxd.res.DefaultFont;

class Main extends hxd.App {
  var map : WorldMap;
  var tf : Text;
  var player : Object;

  static inline var PLAYER_SPEED = 10;

  override function init() {
    map = new WorldMap(16, 256, s3d);

    // add primitive for player mesh
    var cache = new h3d.prim.ModelCache();

    // add player in middle, to move around like a character
    player = cache.loadModel(Res.player);
    player.x = 64;
    player.y = -494 + 64; // skeleton model is off by -494 for some reason, import problem?
    player.z = 5;

    // not sure when but when no longer used?
    // cache.dispose();

    s3d.addChild(player);

    // set camera
    s3d.camera.target.set(64, 64, 0);
    s3d.camera.pos.set(128, 128, 64);
    s3d.camera.zNear = 1;
    s3d.camera.zFar = 100;
    new CameraController(s3d).loadFromCamera();

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    tf = new Text(DefaultFont.get(), s2d);
  }

  override function update(dt: Float) {
    tf.text = 'player pos: [${player.x}, ${player.y}] drawCalls: ${engine.drawCalls}';

    // move player left/right/up/down
    if(Key.isDown(Key.LEFT) || Key.isDown(Key.A)) {
      player.x -= dt * PLAYER_SPEED;
    } else if (Key.isDown(Key.RIGHT) || Key.isDown(Key.D)) {
      player.x += dt * PLAYER_SPEED;
    }

    if(Key.isDown(Key.UP) || Key.isDown(Key.W)) {
      player.y -= dt * PLAYER_SPEED;
    } else if (Key.isDown(Key.DOWN) || Key.isDown(Key.S)) {
      player.y += dt * PLAYER_SPEED;
    }

    if(Key.isDown(Key.ESCAPE)) {
      System.exit();
    }
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
