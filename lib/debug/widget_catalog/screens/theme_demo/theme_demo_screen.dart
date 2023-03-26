import 'package:flutter/material.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/text_theme_demo_screen.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/color_demo_screen.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/color_scheme_demo_screen.dart';

class ThemeDemoScreen extends StatelessWidget {
  const ThemeDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Theme Demo'),
        ),
        body: ListView(
          children: [
            _demoBlock('Color demo', const ColorDemoScreen()),
            _demoBlock(
                'Color scheme demo',
                ColorSchemeDemoScreen(
                  colorScheme: Theme.of(context).colorScheme,
                )),
            _demoBlock('Text theme',
                TextThemeDemoScreen(textTheme: Theme.of(context).textTheme)),
            _demoBlock(
                'Primary text theme',
                TextThemeDemoScreen(
                    textTheme: Theme.of(context).primaryTextTheme))
          ],
        ),
      );

  Widget _demoBlock(String title, Widget screen) => Builder(
      builder: (context) => ListTile(
            title: Text(title),
            onTap: () => navigateTo(context, screen),
            trailing: const Icon(Icons.arrow_right),
          ));

  void navigateTo(BuildContext context, Widget widget) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}
