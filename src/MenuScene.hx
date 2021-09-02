import h2d.Text;
import hxd.Key;
import hxd.System;
import hxd.res.DefaultFont;

class MenuScene extends Scene {
  var menu : Menu;

  public function new(stage : Stage) {
    super(stage);

    var menuItemData = [{
      text: "start",
      action: () -> stage.changeScene(new GameScene(stage))
    }, {
      text: "collision test",
      action: () -> stage.changeScene(new CollisionTestScene(stage))
    }, {
      text: "exit",
      action: () -> System.exit()
    }];

    menu = new Menu(s2d, menuItemData, s2d.width);
    menu.y = s2d.height / 3;
  }

  public override function update(dt: Float) {
    menu.update(dt);
  }
}
