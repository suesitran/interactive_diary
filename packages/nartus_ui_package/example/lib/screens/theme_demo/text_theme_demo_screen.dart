import 'package:example/screens/theme_demo/shared_helper.dart';
import 'package:flutter/material.dart';

class TextThemeDemoScreen extends StatelessWidget {
  const TextThemeDemoScreen({Key? key, required this.textTheme})
      : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Text Theme Demo'),
        ),
        body: ListView(
          children: [
            _createTextStyleDemo('headline 1', textTheme.headline1),
            _createTextStyleDemo('headline 2', textTheme.headline2),
            _createTextStyleDemo('headline 3', textTheme.headline3),
            _createTextStyleDemo('headline 4', textTheme.headline4),
            _createTextStyleDemo('headline 5', textTheme.headline5),
            _createTextStyleDemo('headline 6', textTheme.headline6),
            _createTextStyleDemo('subtitle 1', textTheme.subtitle1),
            _createTextStyleDemo('subtitle 2', textTheme.subtitle2),
            _createTextStyleDemo('bodyText 1', textTheme.bodyText1),
            _createTextStyleDemo('bodyText 2', textTheme.bodyText2),
            _createTextStyleDemo('caption', textTheme.caption),
            _createTextStyleDemo('button', textTheme.button),
            _createTextStyleDemo('overline', textTheme.overline),
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
