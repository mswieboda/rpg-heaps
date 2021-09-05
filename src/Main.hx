import rpg.input.Input;
import rpg.scene.MenuScene;

import hxt.scene.Stage;

import hxd.App;
import hxd.Res;

class Main extends App {
  var stage : Stage;

  override function init() {
    Input.init();

    stage = new Stage(s2d, s3d);
    stage.changeScene(new MenuScene(stage));
  }

  override function update(dt: Float) {
    stage.update(dt);
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
