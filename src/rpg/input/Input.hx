package rpg.input;

import hxd.Pad;

class Input {
  public static inline var game = GameInput;
  public static inline var menu = MenuInput;

  public static var pad(get, never) : Pad;

  public static function init() {
    GamePad.init();
  }

  static function get_pad() : Pad {
    return GamePad.pad;
  }
}
