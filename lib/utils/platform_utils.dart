import 'package:flutter/material.dart' show TargetPlatform, Theme;

bool isAndroid(context) {
  return Theme.of(context).platform == TargetPlatform.android;
}

bool isIOS(context) {
  return Theme.of(context).platform == TargetPlatform.iOS;
}