import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoThemeData, CupertinoTextThemeData;
import 'package:flutter/material.dart'
    show MaterialApp, Brightness, ThemeData, Colors;

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

  CupertinoApp _buildCupertinoApp() => CupertinoApp(
        title: _title,
        theme: _convertToCupertinoThemeData(_theme, _darkTheme),
        routes: _routes ?? {},
        home: _home,
      );

  MaterialApp _buildMaterialApp() => MaterialApp(
        title: _title,
        theme: _theme,
        darkTheme: _darkTheme,
        routes: _routes ?? {},
        home: _home,
      );

  CupertinoThemeData _convertToCupertinoThemeData(
      ThemeData? theme, ThemeData? darkTheme) {
    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    /// in dark mode, use dark theme, else use light theme.
    /// if dark theme is null, use light theme.
    final themeToUse = (brightness == Brightness.dark
            ? darkTheme
            : theme) ?? theme;

    /// if light theme is also null, use default CupertinoThemeData
    return CupertinoThemeData(
        brightness: themeToUse?.brightness,
        primaryColor: themeToUse?.primaryColor,
        barBackgroundColor: themeToUse?.primaryColor,
        primaryContrastingColor: themeToUse?.colorScheme.onPrimary,
        scaffoldBackgroundColor: themeToUse?.scaffoldBackgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: themeToUse?.primaryColor ?? Colors.blue,
          actionTextStyle: themeToUse?.textTheme.button,
          dateTimePickerTextStyle: themeToUse?.textTheme.labelMedium,
          navActionTextStyle: themeToUse?.textTheme.button,
          navLargeTitleTextStyle: themeToUse?.textTheme.labelLarge,
          navTitleTextStyle: themeToUse?.textTheme.labelMedium,
          pickerTextStyle: themeToUse?.textTheme.bodyMedium,
          tabLabelTextStyle: themeToUse?.textTheme.bodyMedium,
          textStyle: themeToUse?.textTheme.bodyMedium
        ));
  }
}
