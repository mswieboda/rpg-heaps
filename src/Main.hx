import h2d.Text;
import h3d.Vector;
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
  var camera : Camera;

  override function init() {
    map = new WorldMap(16, 256, s3d);

    player = new Player(s3d);

    player.x = 64;
    player.y = 64;
    player.z = 0.99;

    camera = new Camera(s3d);

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    tf = new Text(DefaultFont.get(), s2d);
  }

  override function update(dt: Float) {
    tf.text = 'player pos: [${player.x}, ${player.y}] drawCalls: ${engine.drawCalls}';

    player.update(dt);
    camera.update(dt, player);

    if(Key.isDown(Key.ESCAPE)) {
      System.exit();
    }
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
