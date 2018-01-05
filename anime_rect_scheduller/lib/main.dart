import 'package:flutter/material.dart' as sky;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/painting.dart' as sky;
import 'package:flutter/rendering.dart' as sky;
import 'package:flutter/scheduler.dart' as sky;
import 'dart:async';
import 'dart:math' as math;

void main() {
  sky.runApp(new DrawRectWidget()..anime());
}

class DrawRectWidget extends sky.SingleChildRenderObjectWidget {
  DrawRectObject drawObj = new DrawRectObject();
  sky.RenderObject createRenderObject(sky.BuildContext context){
    return drawObj;
  }

  int prevTimeStamp = 0;
  double angle = 0.0;
  Future anime() async {
    //
    // 2016/1/13 add following code
    //  Scheduller == null situation
    if(sky.SchedulerBinding.instance == null) {
      new Future.delayed(new Duration(seconds: 1)).then((_){
        anime();
      });
      return;
    }

    //
    sky.SchedulerBinding.instance.scheduleFrameCallback((Duration timeStamp) {
      print("${timeStamp.inMilliseconds-prevTimeStamp}");
      prevTimeStamp = timeStamp.inMilliseconds;
      drawObj.x = 100 * math.cos(math.PI * angle / 180.0) + 100.0;
      drawObj.y = 100 * math.sin(math.PI * angle / 180.0) + 100.0;
      angle++;
      drawObj.markNeedsPaint();
      anime();
    });
  }
}

class DrawRectObject extends sky.RenderBox {
  double x = 50.0;
  double y = 50.0;
  void paint(sky.PaintingContext context, sky.Offset offset) {
    sky.Paint p = new sky.Paint();
    p.color = new sky.Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    sky.Rect r = new sky.Rect.fromLTWH(x, y, 25.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}
