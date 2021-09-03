package rpg.scene;

import h2d.Text;
import hxd.Key;
import hxd.res.DefaultFont;

class GamePadScene extends Scene {
  var text : Text;

  public function new(stage : Stage) {
    super(stage);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
    text.text = "Waiting for game pad";

    hxd.Pad.wait(onPad);
  }

  public override function update(dt: Float) {
    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }
  }

  function onPad(pad : hxd.Pad) {
    if (!pad.connected)
      text.text = "game pad not connected";

    text.text = "game pad connected";

    pad.onDisconnect = () -> {
      text.text = "game pad disconnected";

      if (pad.connected)
        text.text += "game pad disconnected (called while still connected?)";
    }
  }
}
