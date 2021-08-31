import h2d.Text;
import hxd.res.DefaultFont;

class MenuScene extends Scene {
  var text : Text;

  public function new() {
    super();
    
    text = new Text(DefaultFont.get(), s2d);
    text.text = 'menu testing 123';
  }

  public override function update(dt: Float) {

  }
}
