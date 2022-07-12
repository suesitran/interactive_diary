import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as a;
import 'package:flutter/foundation.dart';

export 'package:flutter/material.dart' hide Scaffold, ScaffoldMessenger;

part 'per_os/screen_impl.dart';

part 'per_os/tab_screen_impl.dart';

abstract class _PlatformScreen extends StatelessWidget {
  const _PlatformScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final a = appBarActions(context);
    final t = title(context);

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _buildCupertino(context, t, a);
    }

    return _buildMaterial(context, t, a);
  }

  Widget _buildCupertino(
      BuildContext context, String? title, List<ScreenAction>? actions);

  Widget _buildMaterial(
      BuildContext context, String? title, List<ScreenAction>? actions);

  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return null;
  }

  List<ScreenAction>? appBarActions(BuildContext context) {
    return null;
  }

  String? title(BuildContext context) {
    return null;
  }
}

class ScreenAction {
  final String? label;
  final IconData? iconData;
  final VoidCallback onPress;

  ScreenAction({this.label, this.iconData, required this.onPress})
      : assert(label != null || iconData != null);

  Widget _toWidget() => iconData == null
      ? TextButton(onPressed: onPress, child: Text(label!))
      : IconButton(onPressed: onPress, icon: Icon(iconData));
}

class FloatingActionButtonConfig {
  final FloatingActionButton button;
  final FloatingActionButtonLocation location;
  final FloatingActionButtonAnimator animator;

  FloatingActionButtonConfig(
      {required this.button,
      this.location = FloatingActionButtonLocation.centerDocked,
      this.animator = FloatingActionButtonAnimator.scaling});

  EdgeInsets _calculateCupertinoPadding(BuildContext context,
      {bool inTab = false}) {
    final screenPadding = MediaQuery.of(context).padding;
    var top = screenPadding.top;
    var left = screenPadding.left;
    var bottom = screenPadding.bottom;
    var right = screenPadding.right;

    switch (location) {
      case FloatingActionButtonLocation.startTop:
        left = 25 + screenPadding.left;
        break;
      case FloatingActionButtonLocation.startDocked:
        left = 25 + screenPadding.left;
        if (inTab) {
          bottom = 25 + screenPadding.bottom;
        }
        break;
      case FloatingActionButtonLocation.startFloat:
        left = 25 + screenPadding.left;
        bottom = 25 + screenPadding.bottom;
        if (inTab) {
          bottom += 50;
        }
        break;
      case FloatingActionButtonLocation.centerTop:
        // nothing
        break;
      case FloatingActionButtonLocation.centerDocked:
        if (inTab) {
          bottom = 25 + screenPadding.bottom;
        }
        break;
      case FloatingActionButtonLocation.centerFloat:
        bottom = 25 + screenPadding.bottom;
        if (inTab) {
          bottom += 50;
        }
        break;
      case FloatingActionButtonLocation.endFloat:
        right = 25 + screenPadding.right;
        bottom = 25 + screenPadding.bottom;
        if (inTab) {
          bottom += 50;
        }
        break;
      case FloatingActionButtonLocation.endTop:
        right = 25 + screenPadding.right;
        break;
      case FloatingActionButtonLocation.endDocked:
        right = 25 + screenPadding.right;
        if (inTab) {
          bottom = 25 + screenPadding.bottom;
        }
    }

    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }

  Alignment _toAlign(FloatingActionButtonLocation location) {
    switch (location) {
      case FloatingActionButtonLocation.centerDocked:
      case FloatingActionButtonLocation.centerFloat:
        return Alignment.bottomCenter;
      case FloatingActionButtonLocation.centerTop:
        return Alignment.topCenter;
      case FloatingActionButtonLocation.endDocked:
      case FloatingActionButtonLocation.endFloat:
        return Alignment.bottomRight;
      case FloatingActionButtonLocation.endTop:
        return Alignment.topRight;
      case FloatingActionButtonLocation.startDocked:
      case FloatingActionButtonLocation.startFloat:
        return Alignment.bottomLeft;
      case FloatingActionButtonLocation.startTop:
        return Alignment.topLeft;
      default:
        return Alignment.bottomCenter;
    }
  }
}
