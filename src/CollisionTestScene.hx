import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.Key;
import hxd.res.DefaultFont;

class CollisionTestScene extends Scene {
  var map : TestMap;
  var text : Text;
  var player : PrimCubePlayer;
  var colliders : Array<PrimCube>;
  var camera : Camera;

  public function new(stage : Stage) {
    super(stage);

    map = new TestMap(128, s3d);

    player = new PrimCubePlayer(s3d, 0x0000cc);
    player.z = 2;

    // colliders
    colliders = [];

    var positions = [
      { x: -10, y: -10, z: 2},
      { x: -25, y: 30, z: 3},
      { x: 10, y: -15, z: 1}
    ];

    for (p in positions) {
      var enemy = new PrimCube(s3d, 0xcc0000);

      enemy.x = p.x;
      enemy.y = p.y;
      enemy.z = p.z;

      colliders.push(enemy);
    }

    camera = new Camera(s3d);

    // add directional light
    new DirLight(new Vector(0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
  }

  public override function update(dt: Float) {
    text.text = 'player pos: [${player.x}, ${player.y}, ${player.z}]';

    player.update(dt, colliders);
    camera.update(dt, player);

    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }
  }
}
