package rpg.scene;

class Stage {
  public var s2d : h2d.Scene;
  public var s3d : h3d.scene.Scene;

  public var scene : Scene;

  public function new(s2d : h2d.Scene, s3d : h3d.scene.Scene) {
    this.s3d = s3d;
    this.s2d = s2d;

    scene = new Scene(this);
  }

  public function update(dt: Float) {
    scene.update(dt);
  }

  public function changeScene(scene : Scene) {
    if (this.scene == scene) {
      return;
    }

    this.scene.remove();
    this.scene = scene;

    s3d.addChild(this.scene.s3d);
    s2d.addChild(this.scene.s2d);
  }
}
