import h2d.Text;
import hxd.Key;
import hxd.System;
import hxd.res.DefaultFont;

class MenuScene extends Scene {
  var menu : Menu;

  public function new(stage : Stage) {
    super(stage);

    menu = new Menu(s2d, ["foo abc 123", "bar asdlkfjlsdjflsjdflkjsd", "baz sdlfkj"], s2d.width);
    menu.y = s2d.height / 3;
  }

  public override function update(dt: Float) {
    menu.update(dt);

    if (Key.isPressed(Key.ENTER)) {
      stage.changeScene(new GameScene(stage));
    } else if (Key.isPressed(Key.ESCAPE)) {
      System.exit();
    }
  }
}
