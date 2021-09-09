package rpg.game;

import h2d.Text;
import h2d.Object;
import hxd.res.DefaultFont;

class HeadsUpDisplay {
  var player : Player;
  var text : Text;

  public function new(player : Player, parent : Object) {
    this.player = player;

    // add debug text/HUD
    text = new Text(DefaultFont.get(), parent);
  }

  public function update(dt: Float) {
    text.text = 'player pos: [${player.x}, ${player.y}, ${player.z}]';
  }
}
