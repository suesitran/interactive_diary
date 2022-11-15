import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Test bottom sheet', () {
    testWidgets(
        'given optional field - icon path, when bottom sheet shown, then show bottom sheet with icon',
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
      expect(count, 1);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets(
        'given no icon, when bottom sheet shown, then show bottom sheet without icon',
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
      expect(count, 1);
      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets(
        'given optional field - icon and secondary btn, when bottom sheet shown, then show bottom sheet with icon and secondary btn',
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
      expect(count1, 1);
      expect(count2, 1);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets(
        'given optional field - secondary btn, when bottom sheet shown, then show bottom sheet without icon and secondary btn',
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
      expect(count1, 1);
      expect(count2, 1);
      expect(find.byType(SvgPicture), findsNothing);
    });
  });
}
