import hxd.App;
import hxd.Key;
import hxd.Res;
import hxd.System;

class Main extends App {
  var stage : Stage;
  var menuScene : Scene;
  var gameScene : Scene;

  override function init() {
    stage = new Stage(s2d, s3d);
    menuScene = new MenuScene();
    gameScene = new GameScene();

    stage.changeScene(menuScene);
  }

  override function update(dt: Float) {
    stage.update(dt);

    if(Key.isPressed(Key.NUMBER_2)) {
      stage.changeScene(gameScene);
    } else if (Key.isPressed(Key.NUMBER_1)) {
      stage.changeScene(menuScene);
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
