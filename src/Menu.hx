import h2d.Object;
import hxd.Key;

class Menu extends Object {
  var items : Array<MenuItem>;
  var selectedIndex : Int;

  public function new(parent: Object, items : Array<String>, width: Int) {
    super(parent);

    selectedIndex = 0;

    var y = 0;

    this.items = [];

    for (item in items) {
      var menuItem = new MenuItem(this, item);

      menuItem.x = width / 2 - menuItem.width / 2;
      menuItem.y = y;

      this.items.push(menuItem);

      y += menuItem.height;
    }

    this.items[0].select();
  }

  public function update(dt: Float) {
    if(Key.isPressed(Key.UP)) {
      selectPreviousItem();
    } else if (Key.isPressed(Key.DOWN)) {
      selectNextItem();
    }
  }

  function selectNextItem() {
    var index = selectedIndex + 1;

    if (index >= items.length) index = 0;

    selectItem(index);
  }

  function selectPreviousItem() {
    var index = selectedIndex - 1;

    if (index < 0) index = items.length - 1;

    selectItem(index);
  }

  function selectItem(index : Int) {
    var item : MenuItem = items[selectedIndex];

    item.deselect();

    selectedIndex = index;

    item = items[selectedIndex];

    item.select();
  }
}
