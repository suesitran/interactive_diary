import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Test primary buttons', () {
    testWidgets('primary button - label only',
        (WidgetTester widgetTester) async {
      const NartusButton primary = NartusButton.primary(
        label: 'Primary',
      );

      await widgetTester.wrapMaterialAndPump(primary);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Primary'), findsOneWidget);

      // SVG Picture should not be found
      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets('primary button - icon only',
        (WidgetTester widgetTester) async {
      const NartusButton primary = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
      );

      await widgetTester.wrapMaterialAndPump(primary);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample'), findsOneWidget);

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('primary button - label and icon, icon position left',
        (WidgetTester widgetTester) async {
      const NartusButton primary = NartusButton.primary(
        label: 'Primary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
      );

      await widgetTester.wrapMaterialAndPump(primary);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Primary'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample, Primary'), findsOneWidget);
    });

    testWidgets('primary button - label and icon, icon position right',
        (WidgetTester widgetTester) async {
      const NartusButton primary = NartusButton.primary(
        label: 'Primary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
      );

      await widgetTester.wrapMaterialAndPump(primary);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Primary'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Primary, Sample'), findsOneWidget);
    });

    // onPress action
    testWidgets('primary button - label only - onPress action',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton primary = NartusButton.primary(
        label: 'Primary',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(primary);

      await widgetTester.tap(find.byType(ElevatedButton));

      expect(count, 1);
    });

    testWidgets('primary button - icon only - onPress action',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton primary = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(primary);

      await widgetTester.tap(find.byType(ElevatedButton));

      expect(count, 1);
    });

    testWidgets(
        'primary button - label and icon, icon position left, onPress action',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton primary = NartusButton.primary(
        label: 'Primary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(primary);

      await widgetTester.tap(find.byType(ElevatedButton));

      expect(count, 1);
    });

    testWidgets(
        'primary button - label and icon, icon position right, onPress action',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton primary = NartusButton.primary(
        label: 'Primary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(primary);

      await widgetTester.tap(find.byType(ElevatedButton));

      expect(count, 1);
    });

    testWidgets('primary button - icon only, sizeType original',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.original,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('primary button - icon only, sizeType large',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.large,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('primary button - icon only, sizeType small',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.small,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('Test secondary buttons', () {
    testWidgets('secondary button - label only',
        (WidgetTester widgetTester) async {
      const NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);

      // SVG Picture should not be found
      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets('secondary button - icon only',
        (WidgetTester widgetTester) async {
      const NartusButton secondary = NartusButton.secondary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample'), findsOneWidget);

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('secondary button - label and icon, icon position left',
        (WidgetTester widgetTester) async {
      const NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample, Secondary'), findsOneWidget);
    });

    testWidgets('secondary button - label and icon, icon position right',
        (WidgetTester widgetTester) async {
      const NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Secondary, Sample'), findsOneWidget);
    });

    // onPress test
    testWidgets('secondary button - label only - onPress',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      await widgetTester.tap(find.byType(OutlinedButton));

      expect(count, 1);
    });

    testWidgets('secondary button - icon only - onPress',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton secondary = NartusButton.secondary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      await widgetTester.tap(find.byType(OutlinedButton));

      expect(count, 1);
    });

    testWidgets(
        'secondary button - label and icon, icon position left - onPress',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      await widgetTester.tap(find.byType(OutlinedButton));

      expect(count, 1);
    });

    testWidgets('secondary button - label and icon, icon position right',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton secondary = NartusButton.secondary(
        label: 'Secondary',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(secondary);

      await widgetTester.tap(find.byType(OutlinedButton));

      expect(count, 1);
    });

    testWidgets('secondary button - icon only, sizeType original',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.secondary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.original,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('secondary button - icon only, sizeType large',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.large,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('secondary button - icon only, sizeType small',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.primary(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        sizeType: SizeType.small,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('Test text buttons', () {
    testWidgets('text button - label only - enable',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.text(
        label: 'Text',
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);

      // SVG Picture should not be found
      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets('text button - icon only - enable',
        (WidgetTester widgetTester) async {
      final NartusButton text = NartusButton.text(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        onPressed: () {},
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample'), findsOneWidget);

      expect(find.byType(Text), findsNothing);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));

      expect(svgPicture.width, 20);
      expect(svgPicture.height, 20);
    });

    testWidgets('text button - icon only - disable',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.text(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample'), findsOneWidget);

      expect(find.byType(Text), findsNothing);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));

      expect(svgPicture.width, 20);
      expect(svgPicture.height, 20);
    });

    testWidgets('text button - label and icon, icon position left',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.text(
        label: 'Text',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Sample, Text'), findsOneWidget);
    });

    testWidgets('text button - label and icon, icon position right',
        (WidgetTester widgetTester) async {
      const NartusButton text = NartusButton.text(
        label: 'Text',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
      );

      await widgetTester.wrapMaterialAndPump(text);

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.bySemanticsLabel('Text, Sample'), findsOneWidget);
    });

    // onPress
    testWidgets('text button - label only - enable - onPress',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton text = NartusButton.text(
        label: 'Text',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(text);

      await widgetTester.tap(find.byType(TextButton));

      expect(count, 1);
    });

    testWidgets('text button - icon only - enable - onPress',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton text = NartusButton.text(
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(text);

      await widgetTester.tap(find.byType(TextButton));

      expect(count, 1);
    });

    testWidgets('text button - label and icon, icon position left',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton text = NartusButton.text(
        label: 'Text',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.left,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(text);

      await widgetTester.tap(find.byType(TextButton));

      expect(count, 1);
    });

    testWidgets('text button - label and icon, icon position right',
        (WidgetTester widgetTester) async {
      int count = 0;
      final NartusButton text = NartusButton.text(
        label: 'Text',
        iconPath: 'assets/facebook.svg',
        iconSemanticLabel: 'Sample',
        iconPosition: IconPosition.right,
        onPressed: () {
          count++;
        },
      );

      await widgetTester.wrapMaterialAndPump(text);

      await widgetTester.tap(find.byType(TextButton));

      expect(count, 1);
    });
  });
}
