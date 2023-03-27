import 'package:flutter/material.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/alertdialog/alert_dialog_demo.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/bottom_sheet/bottom_sheet_demo.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/cta_buttons/cta_buttons_screen.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/location/location_demo_screen.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/text_and_error_label_screen.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/theme_demo_screen.dart';

class WidgetCatalog extends StatelessWidget {
  const WidgetCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Widget catalog'),
        ),
        body: ListView(
          children: [
            const WidgetTile('Theme demo', ThemeDemoScreen()),
            WidgetTile('Text and error label', TextAndErrorLabelScreen()),
            const WidgetTile('CTA Buttons', CTAButtonsScreen()),
            const WidgetTile('Bottom Sheet demo', BottomSheetDemo()),
            const WidgetTile('Alert Dialog demo', AlertDialogDemo()),
            const WidgetTile('Location Demo', LocationDemoScreen()),
          ],
        ),
      );
}

class WidgetTile extends StatelessWidget {
  final String title;
  final Widget catalogScreen;

  const WidgetTile(this.title, this.catalogScreen, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).dividerColor, width: 1.0)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      trailing: const Icon(Icons.arrow_right),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => catalogScreen)),
      title: Text(title));
}
