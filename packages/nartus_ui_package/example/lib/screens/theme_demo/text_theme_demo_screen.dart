import 'package:example/screens/theme_demo/shared_helper.dart';
import 'package:flutter/material.dart';

class TextThemeDemoScreen extends StatelessWidget {
  const TextThemeDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Text Theme Demo'),
    ),
    body: ListView(
      children: [
        _createTextStyleDemo('headline 1', Theme.of(context).textTheme.headline1),
        _createTextStyleDemo('headline 2', Theme.of(context).textTheme.headline2),
        _createTextStyleDemo('headline 3', Theme.of(context).textTheme.headline3),
        _createTextStyleDemo('headline 4', Theme.of(context).textTheme.headline4),
        _createTextStyleDemo('headline 5', Theme.of(context).textTheme.headline5),
        _createTextStyleDemo('headline 6', Theme.of(context).textTheme.headline6),
        _createTextStyleDemo('subtitle 1', Theme.of(context).textTheme.subtitle1),
        _createTextStyleDemo('subtitle 2', Theme.of(context).textTheme.subtitle2),
        _createTextStyleDemo('bodyText 1', Theme.of(context).textTheme.bodyText1),
        _createTextStyleDemo('bodyText 2', Theme.of(context).textTheme.bodyText2),
        _createTextStyleDemo('caption', Theme.of(context).textTheme.caption),
        _createTextStyleDemo('button', Theme.of(context).textTheme.button),
        _createTextStyleDemo('overline', Theme.of(context).textTheme.overline),
      ],
    ),
  );


  Widget _createTextStyleDemo(String title, TextStyle? textStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(title, style: textStyle,),
          subtitle: textStyle == null ? const Text('null') : Column(
            children: [
              createColorDemo('Color', textStyle.color!),
              createColorDemo('backgroundColor', textStyle.backgroundColor),
              createDoubleDemo('fontSize', textStyle.fontSize)
            ],
          ),
        ),
        Divider(thickness: 2.0,)
      ],
    );
  }
}
