import h3d.prim.Cube;
import h3d.mat.Texture;
import h3d.scene.Object;
import h3d.scene.Mesh;
import h3d.scene.World;
import hxd.Res;

class WorldMesh extends World {
  override function initChunkSoil(chunk: WorldChunk) {
    var cube = new Cube(chunkSize, chunkSize, 0);
    cube.addNormals();
    cube.addUVs();

    var soil = new Mesh(cube, chunk.root);
    soil.x = chunk.x;
    soil.y = chunk.y;
    soil.material.texture = Texture.fromColor(0x408020);
    soil.material.shadows = true;
  }

}

class WorldMap extends WorldMesh {
  public function new(
    chunkSize: Int,
    worldSize: Int,
    ?parent: Object,
    autoCollect: Bool = true
  ) {
    super(chunkSize, worldSize, parent, autoCollect);

    var treeModel = loadModel(Res.tree);
    var rockModel = loadModel(Res.rock);

    for(i in 0...500) {
      add(
        Std.random(2) == 0 ? treeModel : rockModel,
        Math.random() * 128,
        Math.random() * 128,
        0,
        1.2 + hxd.Math.srand(0.4),
        hxd.Math.srand(Math.PI)
      );
    }

    done();
  }
}
