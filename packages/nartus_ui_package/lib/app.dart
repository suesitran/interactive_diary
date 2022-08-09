import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoThemeData;
import 'package:flutter/material.dart' show MaterialApp, ThemeData, Brightness;

import 'theme.dart';

enum _AppType { material, cupertino, adaptive }

class App extends StatelessWidget {
  final String _title;
  final Theme? _theme;
  final Theme? _darkTheme;
  final Map<String, WidgetBuilder>? _routes;
  final Widget _home;

  final _AppType _appType;

  const App._(
      {Key? key,
      required Widget home,
      String title = '',
      Theme? theme,
      Theme? darkTheme,
      Map<String, WidgetBuilder>? routes,
      required _AppType appType})
      : _home = home,
        _title = title,
        _theme = theme,
        _darkTheme = darkTheme,
        _routes = routes,
        _appType = appType,
        super(key: key);

  const App.material(
      {Key? key,
      required Widget home,
      String title = '',
      Theme? theme,
      Theme? darkTheme,
      Map<String, WidgetBuilder>? routes})
      : this._(
            key: key,
            home: home,
            title: title,
            theme: theme,
            darkTheme: darkTheme,
            routes: routes,
            appType: _AppType.material);

  const App.cupertino(
      {Key? key,
      required Widget home,
      String title = '',
      Theme? theme,
      Theme? darkTheme,
      Map<String, WidgetBuilder>? routes})
      : this._(
            key: key,
            home: home,
            title: title,
            theme: theme,
            darkTheme: darkTheme,
            routes: routes,
            appType: _AppType.cupertino);

  const App.adaptive(
      {Key? key,
      required Widget home,
      String title = '',
      Theme? theme,
      Theme? darkTheme,
      Map<String, WidgetBuilder>? routes})
      : this._(
            key: key,
            home: home,
            title: title,
            theme: theme,
            darkTheme: darkTheme,
            routes: routes,
            appType: _AppType.adaptive);

  @override
  Widget build(BuildContext context) {
    switch (_appType) {
      case _AppType.material:
        return _buildMaterialApp();
      case _AppType.cupertino:
        return _buildCupertinoApp();
      case _AppType.adaptive:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? _buildCupertinoApp()
            : _buildMaterialApp();
    }
  }

  CupertinoApp _buildCupertinoApp() => CupertinoApp(
        title: _title,
        theme: _convertToCupertinoThemeData(_theme, _darkTheme),
        routes: _routes ?? {},
        home: _home,
      );

  MaterialApp _buildMaterialApp() => MaterialApp(
        title: _title,
        theme: _convertToMaterialThemeData(_theme),
        darkTheme: _convertToMaterialThemeData(_darkTheme),
        routes: _routes ?? {},
        home: _home,
      );

  CupertinoThemeData _convertToCupertinoThemeData(
      Theme? theme, Theme? darkTheme) {
    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    return CupertinoThemeData(
        brightness: brightness == Brightness.dark
            ? darkTheme?.brightness
            : theme?.brightness,
        primaryColor: brightness == Brightness.dark
            ? darkTheme?.primaryColor
            : theme?.primaryColor);
  }

  ThemeData _convertToMaterialThemeData(Theme? theme) {
    return ThemeData(
        brightness: theme?.brightness, primaryColor: theme?.primaryColor);
  }
}
