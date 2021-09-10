package rpg.scene;

import hxt.input.Input;
import hxt.scene.Scene;
import hxt.scene.Stage;
import hxt.ui.Menu;

import h3d.Vector;
import hxd.System;

class MenuScene extends Scene {
  var menu : Menu;

  public function new(stage : Stage) {
    super(stage);

    var menuItemData = [{
      text: "start",
      action: () -> stage.changeScene(new GameScene(stage))
    },
    #if debug
    {
      text: "gamepad",
      action: () -> stage.changeScene(new GamePadScene(stage))
    },
    #end
    {
      text: "exit",
      action: () -> System.exit()
    }];

    menu = new Menu(s2d, menuItemData, s2d.width, null, null, new Vector(0, 1, 0));
    menu.y = s2d.height / 3;
  }

  public override function update(dt: Float) {
    menu.update(dt);

    if (Input.menu.isPressed("exit")) {
      System.exit();
    }
  }
}
