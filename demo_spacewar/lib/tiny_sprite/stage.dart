part of tiny_sprite;

class GameWidget extends sky.SingleChildRenderObjectWidget {
  Stage _stage;
  Stage get stage => _stage;
  GameWidget() {
    _stage = new Stage();
  }

  @override
  sky.RenderObject createRenderObject(sky.BuildContext context) {
    return _stage;
  }
}

typedef Stage_OnTick(Stage);
class Stage extends sky.RenderBox {
  double get x => 0.0;
  double get y => 0.0;
  double get w => (this.hasSize? this.size.width : 0.0);
  double get h => (this.hasSize? this.size.height : 0.0);
  bool isInit = false;

  bool _animeIsStart = false;
  bool get animeIsStart => _animeIsStart;
  DisplayObject _root = new DisplayObject("root");
  DisplayObject get root => _root;

  Stage_OnTick onTickFunc = null;

  int prevTimeStamp = 0;
  Future<Stage> start() async {
    log("start()");
    _animeIsStart = true;
    if(sky.SchedulerBinding.instance == null || this.hasSize == false) {
      new Future.delayed(new Duration(seconds: 1)).then((_){
        start();
      });
      return this;
    }
    sky.SchedulerBinding.instance.scheduleFrameCallback((Duration timeStamp) {
      //print("${timeStamp.inMilliseconds-prevTimeStamp}");
      prevTimeStamp = timeStamp.inMilliseconds;
      if (isInit == false) {
        _root.onInit(this);
        isInit = true;
      }
      if(onTickFunc != null) {
        onTickFunc(this);
      }
      _root.onTick(this);
      this.markNeedsPaint();
      start();
    });
    return this;
  }

  Future<Stage> stop() async {
    log("stop()");
    _animeIsStart = false;
    return null;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    _root.onRelayout(this);
  }

  @override
  bool hitTest(sky.HitTestResult result, {sky.Offset position}) {
    result.add(new sky.BoxHitTestEntry(this, position));
    return true;
  }

  sky.Canvas _currentCanvas;
  sky.Canvas get currentCanvas => _currentCanvas;

  @override
  void paint(sky.PaintingContext context, sky.Offset offset) {
    _currentCanvas = context.canvas;
    _root.onPaint(this);

  }

  Map<int, TouchPoint> touchPoints = {};
  @override
  void handleEvent(sky.PointerEvent event, sky.HitTestEntry entry) {
    if (!(entry is sky.BoxHitTestEntry)) {
      return;
    }
    sky.BoxHitTestEntry en = entry;
    //print("#ON Event");
    if (!touchPoints.containsKey(event.pointer)) {

      touchPoints[event.pointer] =
      new TouchPoint(en.localPosition.dx, en.localPosition.dy);
    }
    if(event is sky.PointerMoveEvent) {
      touchPoints[event.pointer].x = event.position.dx;
      touchPoints[event.pointer].y = event.position.dy;
    }
    _root.onTouch(this, event.pointer, toEvent(event));
    if(event is sky.PointerUpEvent) {
      touchPoints.remove(event.pointer);
    } else if(event is sky.PointerCancelEvent) {
      touchPoints.clear();
    }
  }

  @override
  void attach(sky.PipelineOwner owner) {
    super.attach(owner);
  }

  @override
  void detach() {
    super.detach();
  }
}

String toEvent(sky.PointerEvent e) {
  if(e is sky.PointerUpEvent) {
    return "pointerup";
  }else if(e is sky.PointerDownEvent) {
    return "pointerdown";
  }else if(e is sky.PointerCancelEvent) {
    return "pointercancel";
  }else if(e is sky.PointerMoveEvent) {
    return "pointermove";
  } else {
    return "";
  }
}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}