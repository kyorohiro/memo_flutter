library tiny_sprite;
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/rendering.dart' as sky;
import 'package:flutter/services.dart' as sky;
import 'package:flutter/scheduler.dart' as sky;

part 'stage.dart';
part 'displayobject.dart';
part 'joystick.dart';
part 'sprite.dart';


bool logOn = false;//true;
void log(String message) {
  if(logOn) {
    print(message);
  }
}

class ImageLoader {
  static sky.AssetBundle getAssetBundle() => (sky.rootBundle != null)
      ? sky.rootBundle
      : new sky.NetworkAssetBundle(new Uri.directory(Uri.base.origin));

  static Future<ui.Image> load(String url) async {
    sky.ImageStream stream = new sky.AssetImage(url, bundle: getAssetBundle()).resolve(sky.ImageConfiguration.empty);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    void listener(sky.ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    }
    stream.addListener(listener);
    return completer.future;
  }
}