import h2d.Text;
import hxd.res.DefaultFont;

class MenuScene extends Scene {
  var menu : Menu;

  public function new() {
    super();

    menu = new Menu(s2d, ["foo abc 123", "bar asdlkfjlsdjflsjdflkjsd", "baz sdlfkj"], s2d.width);
    menu.y = s2d.height / 3;
  }

  public override function update(dt: Float) {
    menu.update(dt);
  }
}
