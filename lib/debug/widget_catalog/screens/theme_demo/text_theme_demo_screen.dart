import 'package:flutter/material.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/shared_helper.dart';

class TextThemeDemoScreen extends StatelessWidget {
  const TextThemeDemoScreen({
    required this.textTheme,
    Key? key,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Text Theme Demo'),
        ),
        body: ListView(
          children: [
            _createTextStyleDemo('headline 1', textTheme.displayLarge),
            _createTextStyleDemo('headline 2', textTheme.displayMedium),
            _createTextStyleDemo('headline 3', textTheme.displaySmall),
            _createTextStyleDemo('headline 4', textTheme.headlineMedium),
            _createTextStyleDemo('headline 5', textTheme.headlineSmall),
            _createTextStyleDemo('headline 6', textTheme.titleLarge),
            _createTextStyleDemo('subtitle 1', textTheme.titleMedium),
            _createTextStyleDemo('subtitle 2', textTheme.titleSmall),
            _createTextStyleDemo('bodyText 1', textTheme.bodyLarge),
            _createTextStyleDemo('bodyText 2', textTheme.bodyMedium),
            _createTextStyleDemo('caption', textTheme.bodySmall),
            _createTextStyleDemo('button', textTheme.labelLarge),
            _createTextStyleDemo('overline', textTheme.labelSmall),
          ],
        ),
      );

  Widget _createTextStyleDemo(String title, TextStyle? textStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            title,
            style: textStyle,
          ),
          subtitle: textStyle == null
              ? const Text('null')
              : Column(
                  children: [
                    createColorDemo('Color', textStyle.color!),
                    createColorDemo(
                        'backgroundColor', textStyle.backgroundColor),
                    createDoubleDemo('fontSize', textStyle.fontSize)
                  ],
                ),
        ),
        const Divider(
          thickness: 2.0,
        )
      ],
    );
  }
}
