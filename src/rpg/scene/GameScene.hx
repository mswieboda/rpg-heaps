package rpg.scene;

import rpg.game.Camera;
import rpg.game.ExampleMap;
import rpg.game.Player;

import hxt.input.Input;
import hxt.obj.Collider;
import hxt.obj.Obj;
import hxt.scene.Scene;
import hxt.scene.Stage;

import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.scene.fwd.LightSystem;
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

    var map = new ExampleMap(128, s3d);

    colliderObjs = colliderObjs.concat(map.colliderObjs);

    player = new Player(s3d);
    player.z = 1.1;

    // tree trigger
    var cache = new ModelCache();
    var model = cache.loadModel(Res.tree);
    cache.dispose();

    obj = new Obj(model, Collider.scaleSize(model, new Vector(-1.5, -1.5, 0)), new Vector(10, 10, 10), s3d);
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
