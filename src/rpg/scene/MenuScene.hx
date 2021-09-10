package rpg.scene;

import hxt.input.Input;
import hxt.scene.Scene;
import hxt.scene.Stage;
import hxt.ui.Menu;

import h2d.HtmlText;
import h3d.Vector;
import hxd.System;
import hxd.res.DefaultFont;

class MenuScene extends Scene {
  var header : HtmlText;
  var menu : Menu;

  public function new(stage : Stage) {
    super(stage);

    // NOTE: DefaultFont is 12, so keep factor of 12 for best results
    var headerFont = DefaultFont.get().clone();
    headerFont.resizeTo(36);

    header = new HtmlText(headerFont, s2d);
    header.text = '<font color="#ff0000">rpg</font>-<font color="#00ff00">heaps</font>';
    header.x = s2d.width / 2 - header.textWidth / 2;
    header.y = s2d.height / 5 - header.textHeight / 2;

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

    // NOTE: DefaultFont is 12, so keep factor of 12 for best results
    var menuFont = DefaultFont.get().clone();
    menuFont.resizeTo(24);

    menu = new Menu(s2d, menuItemData, s2d.width / 2, 0x00FF00, null, menuFont);
    menu.y = s2d.height / 3;
  }

  public override function update(dt: Float) {
    menu.update(dt);

    if (Input.menu.isPressed("exit")) {
      System.exit();
    }
  }
}
