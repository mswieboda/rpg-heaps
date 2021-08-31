import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.App;
import hxd.Key;
import hxd.Res;
import hxd.System;
import hxd.res.DefaultFont;
import hxd.SceneEvents;

class Main extends App {
  var scene3d : h3d.scene.Scene;
  var scene2d : h2d.Scene;

  var menuScene3d : h3d.scene.Scene;
  var menuScene2d : h2d.Scene;
  var menuText : Text;

  var gameScene3d : h3d.scene.Scene;
  var gameScene2d : h2d.Scene;
  var map : WorldMap;
  var gameText : Text;
  var player : Player;
  var camera : Camera;

  override function init() {
    // menu scene
    menuScene3d = new h3d.scene.Scene();
    menuScene2d = new h2d.Scene();
    menuText = new Text(DefaultFont.get(), menuScene2d);
    menuText.text = 'menu testing 123';

    // game scene
    gameScene3d = new h3d.scene.Scene();
    gameScene2d = new h2d.Scene();

    map = new WorldMap(16, 256, gameScene3d);

    player = new Player(gameScene3d);

    player.x = 64;
    player.y = 64;
    player.z = 0.99;

    camera = new Camera(gameScene3d);

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), gameScene3d);
    cast(gameScene3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    gameText = new Text(DefaultFont.get(), gameScene2d);

    scene3d = menuScene3d;
    scene2d = menuScene2d;

    s3d.addChild(scene3d);
    s2d.addChild(scene2d);
  }

  override function update(dt: Float) {
    gameText.text = 'player pos: [${player.x}, ${player.y}] drawCalls: ${engine.drawCalls}';

    player.update(dt);
    camera.update(dt, player);

    if(Key.isPressed(Key.NUMBER_2)) {
      trace(">>> switching scene to game");
      switchScene(gameScene3d, gameScene2d);
    } else if (Key.isPressed(Key.NUMBER_1)) {
      trace(">>> switching scene to menu");
      switchScene(menuScene3d, menuScene2d);
    }

    if(Key.isDown(Key.ESCAPE)) {
      System.exit();
    }
  }


  function switchScene(scene3d : h3d.scene.Scene, scene2d : h2d.Scene) {
    if (this.scene3d == scene3d && this.scene2d == scene2d) {
      trace(">>> switchScene same scene, returning");
      return;
    }

    // s3d.removeChild(scene3d);
    // s2d.removeChild(scene2d);

    this.scene3d.remove();
    this.scene2d.remove();

    this.scene3d = null;
    this.scene2d = null;

    this.scene3d = scene3d;
    this.scene2d = scene2d;

    s3d.addChild(this.scene3d);
    s2d.addChild(this.scene2d);
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
