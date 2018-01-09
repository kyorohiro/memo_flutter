part of tiny_sprite;
class Joystick extends Sprite {

  Joystick() :super.empty("joystick");

  double size = 50.0;
  double minWidth = 25.0;
  bool isTouch = false;
  int touchId = 0;
  double minX = 0.0;
  double minY = 0.0;

  double get directionMax => size / 2;

  double get directionX => moveX - minX;

  double get directionY => moveY - minY;

  @override
  void onInit(Stage stage) {
    this.size = stage.h / 6;
    this.minWidth = this.size / 2;
    this.moveX = stage.w / 2 + stage.x;
    this.moveY = (stage.h - this.size) + stage.y;
    this.minX = this.moveX;
    this.minY = this.moveY;
  }

  void onRelayout(Stage stage) {
    onInit(stage);
  }

  @override
  void onPaint(Stage stage) {
    sky.Paint paint = new sky.Paint();
    if (isTouch) {
      paint.color = const sky.Color.fromARGB(0xaa, 0xaa, 0xaa, 0xff);
    } else {
      paint.color = const sky.Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    }
    sky.Rect r1 = new sky.Rect.fromLTWH(moveX - size / 2, moveY - size / 2, size, size);
    sky.Rect r2 = new sky.Rect.fromLTWH(
        minX - minWidth / 2, minY - minWidth / 2, minWidth, minWidth);
    stage.currentCanvas.drawOval(r1, paint);
    stage.currentCanvas.drawOval(r2, paint);
    //print("#A ${this.minX} ${this.minY}");
  }

  @override
  void onTouch(Stage stage, int id, String type) {
    TouchPoint point = stage.touchPoints[id];
    if (isTouch == false) {
      if (distance(point.x, point.y, this.moveX, this.moveY) < minWidth) {
        touchId = id;
        isTouch = true;
        this.minX = point.x;
        this.minY = point.y;
      }
    } else {
      if (id == touchId) {
        if (type == "pointerup") {
          isTouch = false;
          this.minX = this.moveX;
          this.minY = this.moveY;
        } else {
          this.minX = point.x;
          this.minY = point.y;
          double d = distance(this.moveX, this.moveY, this.minX, this.minY);
          if (d > size / 2) {
            double dd = abs(this.minX - this.moveX) + abs(this.minY - this.moveY);
            this.minX = this.moveX + size / 2 * (this.minX - this.moveX) / dd;
            this.minY = this.moveY + size / 2 * (this.minY - this.moveY) / dd;
          }
        }
      }
    }
  }

  double abs(double v) {
    return (v > 0 ? v : -1 * v);
  }

  double distance(double x1, double y1, double x2, double y2) {
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2));
  }
}
