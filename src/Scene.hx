class Scene {
  public var s3d : h3d.scene.Scene;
  public var s2d : h2d.Scene;

  public function new() {
    s3d = new h3d.scene.Scene();
    s2d = new h2d.Scene();
  }

  public function update(dt: Float) {}

  public function remove() {
    s3d.remove();
    s2d.remove();
  }
}
