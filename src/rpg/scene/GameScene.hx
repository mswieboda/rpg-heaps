package rpg.scene;

import rpg.game.Camera;
import rpg.game.ExampleSpace;
import rpg.game.ExampleTinySpace;
import rpg.game.HeadsUpDisplay;
import rpg.game.Player;
import rpg.game.Space;

import hxt.input.Input;
import hxt.scene.Scene;
import hxt.scene.Stage;

class GameScene extends Scene {
  var player : Player;
  var camera : Camera;
  var hud : HeadsUpDisplay;
  var space : Space;
  var spaces : Map<String, Space>;

  public function new(stage : Stage) {
    super(stage);

    player = new Player(s3d);
    player.z = 1.1;

    camera = new Camera(player, s3d);

    hud = new HeadsUpDisplay(player, s2d);

    spaces = new Map<String, Space>();
    spaces["ExampleSpace"] = new ExampleSpace(player, 128);
    spaces["ExampleTinySpace"] = new ExampleTinySpace(player);

    changeSpace(spaces["ExampleTinySpace"]);
  }

  public override function update(dt: Float) {
    space.update(dt);
    camera.update(dt);
    hud.update(dt);

    checkGateways(dt);

    if (Input.game.isPressed("exit")) {
      stage.changeScene(new MenuScene(stage));
    }
  }

  function checkGateways(dt : Float) {
    checkGateway(dt, "ExampleTinySpace", "ExampleSpace");
    checkGateway(dt, "ExampleSpace", "ExampleTinySpace");
  }

  function checkGateway(dt : Float, from : String, to : String) {
    var fromSpace = spaces[from];
    var toSpace = spaces[to];

    if (fromSpace == null || toSpace == null || space != fromSpace) return;

    if (fromSpace.gatewayTeleport(dt, from, to, toSpace)) {
      changeSpace(toSpace);
    }
  }

  public function changeSpace(space : Space) {
    if (this.space == space) {
      return;
    }

    if (this.space != null) {
      this.space.remove();
    }

    this.space = space;

    s3d.addChild(this.space);
  }
}
