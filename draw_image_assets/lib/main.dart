// following code is checked in 2016/03/16

import 'dart:async';
import 'dart:ui' as sky;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
//
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
void main() {
  runApp(new DemoWidget());
}

class DemoWidget extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return new DemoObject();
  }
}

class DemoObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  sky.Image image = null;
  DemoObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }
  loadImage() async {
    if (image == null) {
      image = await ImageLoader.load("assets/sample.jpeg");
      this.markNeedsPaint();
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}

  @override
  void paint(PaintingContext context, Offset offset) {
    loadImage();
    Paint paint = new Paint()..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Offset point = new Offset(x, y);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.drawImage(image, point, paint);
    }
  }

}

class ImageLoader {
  static AssetBundle getAssetBundle() => (rootBundle != null)
      ? rootBundle
      : new NetworkAssetBundle(new Uri.directory(Uri.base.origin));


  static Future<sky.Image> load(String url) async {
    ImageStream stream = new AssetImage(url, bundle: getAssetBundle()).resolve(ImageConfiguration.empty);
    Completer<sky.Image> completer = new Completer<sky.Image>();
    void listener(ImageInfo frame, bool synchronousCall) {
      final sky.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    }
    stream.addListener(listener);
    return completer.future;
  }
}