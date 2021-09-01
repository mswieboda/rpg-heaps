import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.Key;
import hxd.res.DefaultFont;

class GameScene extends Scene {
  var map : WorldMap;
  var text : Text;
  var player : Player;
  var camera : Camera;

  public function new(stage : Stage) {
    super(stage);

    map = new WorldMap(16, 256, s3d);

    player = new Player(s3d);

    player.x = 64;
    player.y = 64;
    player.z = 0.99;

    camera = new Camera(s3d);

    // add directional light
    new DirLight(new Vector( 0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
  }

  public override function update(dt: Float) {
    text.text = 'player pos: [${player.x}, ${player.y}]';

    player.update(dt);
    camera.update(dt, player);

    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }
  }
}
