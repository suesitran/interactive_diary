import 'package:flutter/material.dart';

/// ##############################################################################
/// Create demo by type
Widget createColorDemo(String title, Color? color) => ListTile(
      title: Text(title),
      subtitle: Text('$color'),
      trailing: color == null
          ? const SizedBox()
          : Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(width: 1.5, color: _invert(color))),
            ),
    );

Widget createDoubleDemo(String title, double? value) => ListTile(
      title: Text(title),
      trailing: Text('$value'),
    );

Color _invert(Color color) {
  final r = 255 - color.red;
  final g = 255 - color.green;
  final b = 255 - color.blue;

  return Color.fromARGB((color.opacity * 255).round(), r, g, b);
}
