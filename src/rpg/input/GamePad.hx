package rpg.input;

import hxd.Pad;

class GamePad {
  public static var pad : Pad = Pad.createDummy();

  public static function init() {
    Pad.wait(onPad);
  }

  static function onPad(p : hxd.Pad) {
    pad = p;
  }
}
