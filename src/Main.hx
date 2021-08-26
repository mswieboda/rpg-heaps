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
  // var sceneClass;

  // var menuScene : h2d.Scene;
  // var menuText : Text;

  var gameScene : h3d.scene.Scene;
  var gameScene2d : h2d.Scene;
  var map : WorldMap;
  var gameText : Text;
  var player : Player;
  var camera : Camera;

  override function init() {
    // menu scene
    // menuScene = new h2d.Scene();
    // menuText = new Text(DefaultFont.get(), menuScene);

    // game scene
    gameScene = new h3d.scene.Scene();
    gameScene2d = new h2d.Scene();

    map = new WorldMap(16, 256, gameScene);

    player = new Player(gameScene);

    player.x = 64;
    player.y = 64;
    player.z = 0.99;

    camera = new Camera(gameScene);

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), gameScene);
    cast(gameScene.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    gameText = new Text(DefaultFont.get(), gameScene2d);

    // set the initial scene
    // sceneClass = MenuScene;

    // setScene(menuScene);
    setScene(gameScene);
  }

  override function update(dt: Float) {
    // menuText.text = 'menu testing 123';

    gameText.text = 'player pos: [${player.x}, ${player.y}] drawCalls: ${engine.drawCalls}';

    player.update(dt);
    camera.update(dt, player);

    // if(Key.isPressed(Key.TAB)) {
    //   trace("switching scene");
    //   sceneClass = sceneClass == "MenuScene" ? "GameScene" : "MenuScene";

    //   var scene = sceneClass == "MenuScene" ? new GameScene() : new MenuScene();

    //   setScene(new sceneClass(), false);
    //   trace('switched scene $scene');
    // }

    if(Key.isDown(Key.ESCAPE)) {
      System.exit();
    }
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
