package rpg.scene;

import rpg.game.Camera;
import rpg.game.Map;
import rpg.game.Player;
import rpg.input.Input;
import rpg.obj.Obj;

import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
import hxd.Key;
import hxd.res.DefaultFont;

import h3d.prim.ModelCache;
import hxd.Res;

class GameScene extends Scene {
  var player : Player;
  var colliderObjs : Array<Obj>;
  var obj : Obj;
  var text : Text;
  var camera : Camera;

  public function new(stage : Stage) {
    super(stage);

    colliderObjs = [];

    var map = new Map(128, s3d);

    for (obj in map.colliderObjs) {
      colliderObjs.push(obj);
    }

    player = new Player(s3d);
    player.z = 1.5;

    // tree trigger
    var cache = new ModelCache();
    var model = cache.loadModel(Res.tree);
    cache.dispose();

    obj = new Obj(model, { x: -1.5, y: -1.5, z: 0 }, { x: 10, y: 10, z: 10 }, s3d);
    obj.x = 5;
    obj.y = 10;
    obj.z = 0;

    colliderObjs.push(obj);

    camera = new Camera(s3d);

    // add directional light
    new DirLight(new Vector(0.3, -0.4, -0.9), s3d);
    cast(s3d.lightSystem, LightSystem).ambientLight.setColor(0x909090);

    // add debug text/HUD
    text = new Text(DefaultFont.get(), s2d);
  }

  public override function update(dt: Float) {
    text.text = 'player pos: [${player.x}, ${player.y}, ${player.z}]';

    player.updateWithColliders(dt, colliderObjs);
    camera.update(dt, player);

    if (obj.triggered(player)) {
      text.text += '\nboom!';
    }

    if (Input.game.isPressed("exit")) {
      stage.changeScene(new MenuScene(stage));
    }
  }
}
