package rpg.input;

class Input {
  public static inline var game = GameInput;
  public static inline var menu = MenuInput;

  public static function init() {
    hxt.input.Input.init();
  }
}
