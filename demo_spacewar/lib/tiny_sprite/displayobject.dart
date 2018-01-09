part of tiny_sprite;

class DisplayObject {

  String _objectName;
  String get objectName => _objectName;
  sky.Matrix4 mat;

  DisplayObject(String objectName) {
    _objectName = objectName;
    mat = new sky.Matrix4.zero()..setIdentity();
  }

  List<DisplayObject> _childs = <DisplayObject>[];

  void addChild(DisplayObject obj) {
    _childs.add(obj);
  }

  void rmChild(DisplayObject obj) {
    _childs.remove(obj);
  }

  void onInit(Stage stage) {
    for(DisplayObject c in _childs) {
      c.onInit(stage);
    }
  }

  void onPaint(Stage stage) {
    for(DisplayObject c in _childs) {
      c.onPaint(stage);
    }
  }

  void onTouch(Stage stage, int pointer, String type) {
    for(DisplayObject c in _childs) {
      c.onTouch(stage, pointer, type);
    }
  }

  void onTick(Stage stage) {
    for(DisplayObject c in _childs) {
      c.onTick(stage);
    }
  }

  void onRelayout(Stage stage) {
    for(DisplayObject c in _childs) {
      c.onRelayout(stage);
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

