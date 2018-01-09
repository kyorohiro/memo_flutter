part of tiny_sprite;

class DisplayObject {
  double x = 0.0;
  double y = 0.0;
  double dx = 0.0;
  double dy = 0.0;

  String _objectName;
  String get objectName => _objectName;
  DisplayObject(String objectName) {
    _objectName = objectName;
  }

  List<DisplayObject> _childs = <DisplayObject>[];

  void addChild(DisplayObject obj) {
    _childs.add(obj);
  }

  void rmChild(DisplayObject obj) {
    _childs.remove(obj);
  }

  void onInit(Stage stage) {
    log("onInit()");
    for(DisplayObject c in _childs) {
      c.onInit(stage);
    }
  }

  void onPaint(Stage stage) {
    log("onPaint()");
    for(DisplayObject c in _childs) {
      c.onPaint(stage);
    }
  }

  void onTouch(Stage stage, int pointer, String type) {
    log("onTouch()");
    for(DisplayObject c in _childs) {
      c.onTouch(stage, pointer, type);
    }
  }

  void onTick(Stage stage) {
    for(DisplayObject c in _childs) {
      c.onTick(stage);
    }
  }

  DisplayObject findObjectFromObjectName(String objectName, {int depth=1}) {
    if (this.objectName == objectName) {
      return this;
    }
    if(depth > 0) {
      for (DisplayObject d in _childs) {
        DisplayObject t = d.findObjectFromObjectName(objectName,depth: depth-1);
        if (t != null) {
          return t;
        }
      }
    }
    return null;
  }
}

