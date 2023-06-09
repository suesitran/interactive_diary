import 'package:flutter/material.dart' show BuildContext, TargetPlatform, Theme;

extension PlatformContext on BuildContext {
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
}
