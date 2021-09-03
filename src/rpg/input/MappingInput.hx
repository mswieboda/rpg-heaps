package rpg.input;

import hxd.Key;

class MappingInput {
  public static function isPressed(input_map : Map<String, Array<String>>) : Bool {
    for (buttonId in gamepadIds(input_map["gamepad"])) {
      if (Input.pad.isPressed(buttonId)) return true;
    }

    for (keyId in keyIds(input_map["keys"])) {
      if (Key.isPressed(keyId)) return true;
    }

    return false;
  }

  public static function isDown(input_map : Map<String, Array<String>>) : Bool {
    for (buttonId in gamepadIds(input_map["gamepad"])) {
      if (Input.pad.isDown(buttonId)) return true;
    }

    for (keyId in keyIds(input_map["keys"])) {
      if (Key.isDown(keyId)) return true;
    }

    return false;
  }

  static function gamepadIds(buttons : Array<String>) : Array<Int> {
    if (!Input.pad.connected)
      return [];

    return buttons.map(button -> Reflect.field(Input.pad.config, button));
  }

  static function keyIds(keys : Array<String>) : Array<Int> {
    return keys.map(key -> Reflect.field(Key, key));
  }
}
