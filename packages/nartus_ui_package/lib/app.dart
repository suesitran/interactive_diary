import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoThemeData, CupertinoTextThemeData;
import 'package:flutter/material.dart'
    show MaterialApp, Brightness, ThemeData, Colors, Theme;

enum _AppType { material, cupertino, adaptive }

class App extends StatelessWidget {
  final String _title;
  final ThemeData? _theme;
  final ThemeData? _darkTheme;
  final Map<String, WidgetBuilder>? _routes;
  final Widget _home;

  final _AppType _appType;

  const App._(
      {Key? key,
      required Widget home,
      String title = '',
      ThemeData? theme,
      ThemeData? darkTheme,
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
      ThemeData? theme,
      ThemeData? darkTheme,
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
      ThemeData? theme,
      ThemeData? darkTheme,
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
      ThemeData? theme,
      ThemeData? darkTheme,
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

  CupertinoApp _buildCupertinoApp() {
    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;
    final ThemeData? selectedTheme = (brightness == Brightness.dark ? _darkTheme : _theme) ?? _theme;

    if (selectedTheme != null) {
      return CupertinoApp(
        title: _title,
        routes: _routes ?? {},
        home: Theme(
          data: selectedTheme,
          child: _home,
        ),
      );
    }

    return CupertinoApp(
      title: _title,
      routes: _routes ?? {},
      home: _home,
    );
  }

  MaterialApp _buildMaterialApp() => MaterialApp(
        title: _title,
        theme: _theme,
        darkTheme: _darkTheme,
        routes: _routes ?? {},
        home: _home,
      );
}
