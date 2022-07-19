import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoThemeData;
import 'package:flutter/material.dart' show MaterialApp, ThemeData, Brightness;

import 'theme.dart';

class App extends StatelessWidget {
  final String title;
  final Theme? theme;
  final Theme? darkTheme;
  final Map<String, WidgetBuilder>? routes;
  final Widget home;

  App({
    required this.home,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.routes,
  });

  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoApp(
        title: title,
        theme: _convertToCupertinoThemeData(theme, darkTheme),
        routes: routes ?? {},
        home: home,
      );
    }

    return MaterialApp(
      title: title,
      theme: _convertToMaterialThemeData(theme),
      darkTheme: _convertToMaterialThemeData(darkTheme),
      routes: routes ?? {},
      home: home,
    );
  }

  CupertinoThemeData _convertToCupertinoThemeData(Theme? theme, Theme? darkTheme) {
    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;

    return CupertinoThemeData(
      brightness: brightness == Brightness.dark ? darkTheme?.brightness : theme?.brightness,
      primaryColor: brightness == Brightness.dark ? darkTheme?.primaryColor : theme?.primaryColor
    );
  }

  ThemeData _convertToMaterialThemeData(Theme? theme) {
    return ThemeData(
      brightness: theme?.brightness,
      primaryColor: theme?.primaryColor
    );
  }
}
