import h2d.Text;
import h3d.Vector;
import h3d.col.Collider;
import h3d.col.Ray;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.Key;
import hxd.res.DefaultFont;

class CollisionTestScene extends Scene {
  var map : TestMap;
  var text : Text;
  var player : PrimCubePlayer;
  var enemy : PrimCube;
  var camera : Camera;

  public function new(stage : Stage) {
    super(stage);

    map = new TestMap(128, s3d);

    player = new PrimCubePlayer(s3d, 0x0000cc);

    player.x = 64;
    player.y = 64;
    player.z = 2;

    enemy = new PrimCube(s3d, 0xcc0000);

    enemy.x = 50;
    enemy.y = 50;
    enemy.z = 2;

    camera = new Camera(s3d);

    // add directional light
    new DirLight(new Vector(0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
  }

  public override function update(dt: Float) {
    text.text = 'player pos: [${player.x}, ${player.y}, ${player.z}]';

    player.update(dt);
    enemy.update(dt);
    camera.update(dt, player);

    checkCollisions();

    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }
  }

  function checkCollisions() {
    var playerBounds = player.getBounds();
    var enemyBounds = enemy.getBounds();

    if (playerBounds.collide(enemyBounds)) {
      text.text = 'player colliding with enemy';
      player.onCollided(enemy);
      enemy.onCollided(player);
    }
  }
}
