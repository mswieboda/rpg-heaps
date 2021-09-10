package rpg.game;

import h2d.Text;
import h2d.Object;
import hxd.res.DefaultFont;

class HeadsUpDisplay {
  var player : Player;
  var debugText : Text;

  public function new(player : Player, parent : Object) {
    this.player = player;

    #if debug
    // add debug text/HUD
    debugText = new Text(DefaultFont.get(), parent);
    #end
  }

  public function update(dt: Float) {
    if (debugText != null) {
      debugText.text = 'player pos: [${player.x}, ${player.y}, ${player.z}]';
    }
  }
}
