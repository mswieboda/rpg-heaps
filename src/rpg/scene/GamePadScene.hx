package rpg.scene;

import h2d.Text;
import hxd.Key;
import hxd.Pad;
import hxd.res.DefaultFont;

class GamePadScene extends Scene {
  var pad : Pad;
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

    if (pad != null)
      updatePad(pad);
  }

  function onPad(pad : hxd.Pad) {
    this.pad = pad;

    if (!pad.connected)
      text.text += "\ngame pad not connected";

    text.text += "\ngame pad connected";

    pad.onDisconnect = () -> {
      text.text += "\ngame pad disconnected";

      if (pad.connected)
        text.text += " (called while still connected?)";
    }
  }

  function updatePad(pad : Pad) {
    var buttons = ["A","B","X","Y","LB","RB","LT","RT","back","start","dpadUp","dpadDown","dpadLeft","dpadRight"];

    for (button in buttons) {
      var buttonId = Reflect.field(pad.config, button);

      if (pad.isPressed(buttonId)) {
        text.text += "\n" + button + " isPressed";
      }
    }
  }
}
