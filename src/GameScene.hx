import h2d.Text;
import h3d.Vector;
import h3d.col.Collider;
import h3d.col.Ray;
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

    map = new WorldMap(128, s3d);

    player = new Player(s3d);

    player.x = 64;
    player.y = 64;
    player.z = 5;

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
    camera.update(dt, player);

    checkCollisions();

    if (Key.isPressed(Key.ESCAPE)) {
      stage.changeScene(new MenuScene(stage));
    }
  }

  function checkCollisions() {
    //x,y,z is the Spheres current position,  vec is the movement vector
    var vec = new Vector(1, 0, 0);
    var ray = Ray.fromValues(player.x, player.y, player.z, vec.x, vec.y, vec.z);

    for (child in map.colliderObjects) {
      var collider = child.getCollider();
      // trace(">>> child: " + child + " collider: " + collider);
      var checkCol = child.getCollider().rayIntersection(ray, true);

      if(checkCol != -1 /*&& checkCol <= vec.length()*/) {
        trace("collision:", checkCol, child.toString(), ray);
      }
    }
  }
}
