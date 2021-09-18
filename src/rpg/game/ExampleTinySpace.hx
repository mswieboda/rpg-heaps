package rpg.game;

import rpg.game.Gateway;

import hxt.obj.Collider;
import hxt.obj.Obj;

import h3d.Vector;
import h3d.mat.Texture;
import h3d.prim.Cube;
import h3d.prim.ModelCache;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.scene.fwd.DirLight;
import hxd.Res;

class ExampleTinySpace extends Space {
  public function new(
    player : Player,
    ?parent : Object
  ) {
    super(player, 32, parent);
  }

  override public function initPlane() {
    var halfWorldSize = Std.int(worldSize / 2);
    var tileSize = 4;
    var tiles = Std.int(worldSize / tileSize);

    var cube = new Cube(tileSize, tileSize, 0);
    cube.addNormals();
    cube.addUVs();

    for (x in 0...tiles) {
      for (y in 0...tiles) {
        var soil = new Mesh(cube, this);
        var yOddEven = x % 2 == 0 ? 1 : 0;
        #if debug
        var color = y % 2 == yOddEven ? 0x408020 : 0x204010;
        #else
        var color = 0x408020;
        #end
        soil.material.texture = Texture.fromColor(color);
        soil.material.shadows = false;
        soil.x = x * tileSize - halfWorldSize;
        soil.y = y * tileSize - halfWorldSize;
      }
    }
  }

  override function initLights() {
    // add directional light
    new DirLight(new Vector(0.3, -0.4, -0.9), this);
  }

  override function initGateways() {
    // cave model
    var back = new Cube(5, 10, 5, true);
    back.addNormals();
    back.addUVs();

    var model = new Mesh(back);
    var gateway = new Gateway(
      new Vector(0, -1, 0),
      model,
      new Vector(5, 10, 5),
      new Vector(5, 5, 5),
      this
    );
    gateway.trigger.x = -2.5;
    gateway.x = 5;
    gateway.y = 10;
    gateway.z = 2.5;

    gateways["ExampleSpace"] = gateway;

    // maybe add all gateways as colliderObjs at the end?
    // or no b/c maybe we want some gateway to not be collidable
    colliderObjs.push(gateway);

    // cave container obj
    var cave = new Object(this);
    cave.addChild(gateway);

    // cave side top
    var side = new Cube(2.5, 2.5, 5, true);
    side.addNormals();
    side.addUVs();

    var obj;
    model = new Mesh(side, this);
    obj = new Obj(model, Collider.scaleSize(model, new Vector(0, 0, 0)), null, this);
    obj.x = gateway.x - 3.75;
    obj.y = gateway.y - 3.75;
    obj.z = gateway.z;
    colliderObjs.push(obj);
    cave.addChild(obj);

    // cave side bottom
    side = new Cube(2.5, 2.5, 5, true);
    side.addNormals();
    side.addUVs();

    model = new Mesh(side, this);
    obj = new Obj(model, Collider.scaleSize(model, new Vector(0, 0, 0)), null, this);
    obj.x = gateway.x - 3.75;
    obj.y = gateway.y + 3.75;
    obj.z = gateway.z;
    colliderObjs.push(obj);
    cave.addChild(obj);

    // TODO: when Gateway takes into account rotation/direction better for playerMoveIn/Out rotate cave:
    // cave.rotate(0, 0, hxd.Math.srand(Math.PI));
  }
}
