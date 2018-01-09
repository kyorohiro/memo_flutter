import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/rendering.dart' as sky;
import 'package:flutter/services.dart' as sky;
import 'package:flutter/scheduler.dart' as sky;

import 'tiny_sprite/tiny_sprite.dart';

void main() {
  GameWidget game = new GameWidget();
  Sun sun = new Sun();
  Joystick joystick =new Joystick();
  Sprite sprite = new Sprite("sample", "assets/sample.jpeg");

  game.stage.root.addChild(sun);
  game.stage.root.addChild(joystick);
  game.stage.root.addChild(sprite);

  sky.runApp(game);
  game.stage.start();
  game.stage.onTickFunc = (Stage stage) {
    sprite.rotateZ +=0.1;
    sprite.scaleX = 0.1;
    sprite.scaleY = 0.1;
    sprite.scaleZ = 0.1;
    sun.moveX = stage.x + stage.w /2;
    sun.moveY = stage.y + stage.h /2;
  };

  /*
  game.stage.root.addChild(new Bullet(x:20.0,y:40.0,dx:0.0,dy:0.0));
  game.stage.root.addChild(new Bullet(x:40.0,y:20.0,dx:0.1,dy:0.3));
  game.stage.root.addChild(new Bullet(x:80.0,y:160.0,dx:0.2,dy:0.2));
  game.stage.root.addChild(new Bullet(x:160.0,y:320.0,dx:0.4,dy:0.1));
  game.stage.root.addChild(new Bullet(x:320.0,y:80.0,dx:0.0,dy:0.0));
  game.stage.root.addChild(new Bullet(x:400.0,y:20.0,dx:0.1,dy:0.2));
  */
}



class Sun extends Sprite {
  Sun():super.empty("sun");
  void onPaintAfterTransform(Stage stage) {
    log("Sun:onPaint()");
    sky.Paint paint = new sky.Paint();
    paint.color = const sky.Color.fromARGB(0xaa, 0xff, 0x77, 0x77);
    sky.Rect r = new sky.Rect.fromLTWH(-15.0, -15.0, 30.0, 30.0);
    stage.currentCanvas.drawOval(r, paint);
  }
}
/*
class Bullet extends DisplayObject {

  Bullet({double x:0.0,double y:0.0,double dx:0.0,double dy:0.0}):super("bullet") {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
  }

  void onTick(Stage stage) {
    log("Bullet:onTick()");
    DisplayObject sun = stage.root.findObjectFromObjectName("sun");
    List<double>dxdy = calcGravityDxDy(sun);
    this.dx += dxdy[0];
    this.dy += dxdy[1];
    this.x += this.dx ;
    this.y += this.dy;
  }

  double abs(double v) => (v > 0 ? v : -1 * v);
  double power = 30.0;

  List<double> calcGravityDxDy(DisplayObject obj) {
    double tx = obj.x - this.x;
    double ty = obj.y - this.y;
    double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
    double da = power / math.pow(distance, 2);
    double tt = abs(tx) + abs(ty);
    return [da * (tx / tt), da * (ty / tt), da, distance, tx, ty];
  }

  void onPaint(Stage stage) {
    log("Bullet:onPaint()");
    sky.Paint paint = new sky.Paint();
    paint.color = const sky.Color.fromARGB(0xaa, 0xff, 0xff, 0x00);
    sky.Rect r = new sky.Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
    stage.currentCanvas.drawOval(r, paint);
  }
}
*/