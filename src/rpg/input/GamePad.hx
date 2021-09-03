package rpg.input;

import hxd.Pad;
import hxd.res.DefaultFont;

class GamePad {
  public static var pad : Pad = Pad.createDummy();

  public static function init() {
    Pad.wait(onPad);
  }

  static function onPad(p : hxd.Pad) {
    pad = p;
  }
}
