package rpg.input;

import hxd.Key;

class GameInput extends MappingInput {
  public static var INPUT_MAP : Map<String, Map<String, Array<String>>> = [
    "moveLeft" => [
      "keys" => ["LEFT", "A"],
      "gamepad" => ["dpadLeft"]
    ],
    "moveRight" => [
      "keys" => ["RIGHT", "D"],
      "gamepad" => ["dpadRight"]
    ],
    "moveForward" => [
      "keys" => ["UP", "W"],
      "gamepad" => ["dpadUp"]
    ],
    "moveBackward" => [
      "keys" => ["DOWN", "S"],
      "gamepad" => ["dpadDown"]
    ],
    "moveUp" => [
      "keys" => ["E"],
      "gamepad" => ["LB"]
    ],
    "moveDown" => [
      "keys" => ["Q"],
      "gamepad" => ["RB"]
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
