import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Test nartus bottom sheet', () {
    testWidgets(
        'given icon and no secondary button, when bottom sheet shown, then show bottom sheet with icon and without secondary button',
        (WidgetTester widgetTester) async {
      // given
      int count = 0;
      final NartusBottomSheet btmSheetWithIcon = NartusBottomSheet(
          iconPath: 'assets/facebook.svg',
          title: 'title',
          content: 'content',
          primaryButtonText: 'primaryButtonText',
          onPrimaryButtonSelected: () {
            count++;
          });

      await widgetTester.wrapMaterialAndPump(btmSheetWithIcon);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count, 1);
    });

    testWidgets(
        'given no icon and no secondary button, when bottom sheet shown, then show bottom sheet without icon and secondary button',
        (WidgetTester widgetTester) async {
      // given
      int count = 0;
      final NartusBottomSheet btmSheetWithIcon = NartusBottomSheet(
          title: 'title',
          content: 'content',
          primaryButtonText: 'primaryButtonText',
          onPrimaryButtonSelected: () {
            count++;
          });

      await widgetTester.wrapMaterialAndPump(btmSheetWithIcon);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count, 1);
    });

    testWidgets(
        'given icon and secondary btn, when bottom sheet shown, then show bottom sheet with icon and secondary btn',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusBottomSheet btmSheetWithIcon = NartusBottomSheet(
        iconPath: 'assets/facebook.svg',
        title: 'title',
        content: 'content',
        primaryButtonText: 'primaryButtonText',
        onPrimaryButtonSelected: () {
          count1++;
        },
        secondaryButtonText: 'secondaryButtonText',
        onSecondButtonSelected: () {
          count2++;
        },
      );

      await widgetTester.wrapMaterialAndPump(btmSheetWithIcon);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);
    });

    testWidgets(
        'given no icon and secondary btn, when bottom sheet shown, then show bottom sheet without icon and secondary btn',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusBottomSheet btmSheetWithIcon = NartusBottomSheet(
        title: 'title',
        content: 'content',
        primaryButtonText: 'primaryButtonText',
        onPrimaryButtonSelected: () {
          count1++;
        },
        secondaryButtonText: 'secondaryButtonText',
        onSecondButtonSelected: () {
          count2++;
        },
      );

      await widgetTester.wrapMaterialAndPump(btmSheetWithIcon);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);
    });
  });
}
