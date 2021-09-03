package rpg.scene;

import rpg.input.GamePad;

import h2d.Text;
import hxd.Key;
import hxd.res.DefaultFont;

class GamePadScene extends Scene {
  var text : Text;
  var wasConnected = false;

  public function new(stage : Stage) {
    super(stage);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
    text.text = "waiting for game pad...";
  }

  public override function update(dt: Float) {
    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }

    updatePad();
  }

  function updatePad() {
    var pad = GamePad.pad;

    if (!pad.connected) {
      if (wasConnected) {
        wasConnected = false;
        text.text += "\ngame pad disconnected";
        text.text += "\nwaiting for game pad...";
      }

      return;
    }

    if (!wasConnected) {
      wasConnected = true;
      text.text += "\ngame pad connected";
    }

    var buttons = ["A","B","X","Y","LB","RB","LT","RT","back","start","dpadUp","dpadDown","dpadLeft","dpadRight"];

    for (button in buttons) {
      var buttonId = Reflect.field(pad.config, button);

      if (pad.isPressed(buttonId)) {
        text.text += "\n" + button + " isPressed";
      }
    }
  }
}
