package rpg.input;

import hxd.Key;

class MenuInput extends MappingInput {
  public static var INPUT_MAP : Map<String, Map<String, Array<String>>> = [
    "select" => [
      "keys" => ["SPACE", "ENTER"],
      "gamepad" => ["A"]
    ],
    "up" => [
      "keys" => ["UP", "W"],
      "gamepad" => ["dpadUp"]
    ],
    "down" => [
      "keys" => ["DOWN", "S"],
      "gamepad" => ["dpadDown"]
    ],
    "exit" => [
      "keys" => ["ESCAPE"],
      "gamepad" => ["back"]
    ]
  ];

  public static function isPressed(action : String) : Bool {
    return MappingInput.isPressed(INPUT_MAP[action]);
  }

  public static function isDown(action : String) : Bool {
    return MappingInput.isDown(INPUT_MAP[action]);
  }
}
