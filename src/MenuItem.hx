import h2d.Text;
import h2d.Object;
import h3d.Vector;
import hxd.Key;
import hxd.res.DefaultFont;

class MenuItem extends Object {
  var text : Text;
  var selected : Bool = false;
  var action : Void -> Void;

  public var width(get, never) : Int;
  public var height(get, never) : Int;

  public function new(parent: Object, text : String, action : Void -> Void) {
    super(parent);

    this.text = new Text(DefaultFont.get(), this);
    this.text.text = text;
    this.action = action;
  }

  function get_width() {
    return Std.int(text.textWidth);
  }

  function get_height() {
    return Std.int(text.textHeight);
  }

  public function update(dt: Float) {
    if (selected && Key.isPressed(Key.ENTER)) {
      action();
    }
  }

  public function deselect() {
    selected = false;
    setColor();
  }

  public function select() {
    selected = true;
    setColor();
  }

  function setColor() {
    text.color = selected ? new Vector(1, 0, 0, 1) : new Vector(1, 1, 1, 1);
  }
}
