package rpg.scene;

import rpg.game.Camera;
import rpg.game.ExampleMap;
import rpg.game.HeadsUpDisplay;
import rpg.game.Map;
import rpg.game.Player;

import hxt.input.Input;
import hxt.scene.Scene;
import hxt.scene.Stage;

class GameScene extends Scene {
  var player : Player;
  var hud : HeadsUpDisplay;
  var map : Map;

  public function new(stage : Stage) {
    super(stage);

    player = new Player(s3d);
    player.z = 1.1;

    hud = new HeadsUpDisplay(player, s2d);
    map = new ExampleMap(player, 128, s3d);
  }

  public override function update(dt: Float) {
    hud.update(dt);
    map.update(dt);

    if (Input.game.isPressed("exit")) {
      stage.changeScene(new MenuScene(stage));
    }
  }
}
