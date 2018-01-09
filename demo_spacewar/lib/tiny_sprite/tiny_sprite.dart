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


bool logOn = false;//true;
void log(String message) {
  if(logOn) {
    print(message);
  }
}