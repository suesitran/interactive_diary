import 'package:flutter/material.dart';
import 'package:interactive_diary/debug/widget_catalog/screens/theme_demo/shared_helper.dart';

class ColorSchemeDemoScreen extends StatelessWidget {
  const ColorSchemeDemoScreen({
    required this.colorScheme,
    Key? key,
  }) : super(key: key);

  final ColorScheme colorScheme;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Color demo'),
      ),
      body: ListView(
        children: [
          createColorDemo('primary', colorScheme.primary),
          createColorDemo('onPrimary', colorScheme.onPrimary),
          createColorDemo('primaryContainer', colorScheme.primaryContainer),
          createColorDemo('onPrimaryContainer', colorScheme.onPrimaryContainer),
          createColorDemo('secondary', colorScheme.secondary),
          createColorDemo('onSecondary', colorScheme.onSecondary),
          createColorDemo('secondaryContainer', colorScheme.secondaryContainer),
          createColorDemo(
              'onSecondaryContainer', colorScheme.onSecondaryContainer),
          createColorDemo('tertiary', colorScheme.tertiary),
          createColorDemo('onTertiary', colorScheme.onTertiary),
          createColorDemo('tertiaryContainer', colorScheme.tertiaryContainer),
          createColorDemo(
              'onTertiaryContainer', colorScheme.onTertiaryContainer),
          createColorDemo('error', colorScheme.error),
          createColorDemo('onError', colorScheme.onError),
          createColorDemo('errorContainer', colorScheme.errorContainer),
          createColorDemo('onErrorContainer', colorScheme.onErrorContainer),
          createColorDemo('background', colorScheme.background),
          createColorDemo('onBackground', colorScheme.onBackground),
          createColorDemo('surface', colorScheme.surface),
          createColorDemo('onSurface', colorScheme.onSurface),
          createColorDemo('surfaceVariant', colorScheme.surfaceVariant),
          createColorDemo('onSurfaceVariant', colorScheme.onSurfaceVariant),
          createColorDemo('outline', colorScheme.outline),
          createColorDemo('shadow', colorScheme.shadow),
          createColorDemo('inverseSurface', colorScheme.inverseSurface),
          createColorDemo('inversePrimary', colorScheme.inversePrimary),
        ],
      ));
}
