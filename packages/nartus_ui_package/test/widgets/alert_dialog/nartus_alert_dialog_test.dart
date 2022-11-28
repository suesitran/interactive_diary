import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Test nartus alert dialog', () {
    testWidgets(
        'nartus alert dialog - icon and no secondary button and no text button',
        (WidgetTester widgetTester) async {
      // given
      int count = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
          iconPath: 'assets/facebook.svg',
          title: 'title',
          content: 'content',
          primaryButtonText: 'primaryButtonText',
          onPrimaryButtonSelected: () {
            count++;
          });

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.text('textButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count, 1);
    });

    testWidgets(
        'nartus alert dialog - icon and secondary btn and no text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
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

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);
    });

    testWidgets(
        'nartus alert dialog - icon and no secondary btn and text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
        iconPath: 'assets/facebook.svg',
        title: 'title',
        content: 'content',
        primaryButtonText: 'primaryButtonText',
        onPrimaryButtonSelected: () {
          count1++;
        },
        textButtonText: 'textButtonText',
        onTextButtonSelected: () {
          count2++;
        },
      );

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('textButtonText'));
      expect(count2, 1);
    });

    testWidgets('nartus alert dialog - icon and secondary btn and text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      int count3 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
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
        textButtonText: 'textButtonText',
        onTextButtonSelected: () {
          count3++;
        },
      );

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);

      await widgetTester.tap(find.text('textButtonText'));
      expect(count3, 1);
    });

    testWidgets(
        'nartus alert dialog - no icon and secondary btn and no text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
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

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);
    });

    testWidgets(
        'nartus alert dialog - no icon and secondary btn and text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      int count3 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
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
        textButtonText: 'textButtonText',
        onTextButtonSelected: () {
          count3++;
        },
      );

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('secondaryButtonText'));
      expect(count2, 1);

      await widgetTester.tap(find.text('textButtonText'));
      expect(count3, 1);
    });

    testWidgets(
        'nartus alert dialog - no icon and no secondary btn and text button',
        (WidgetTester widgetTester) async {
      // given
      int count1 = 0;
      int count2 = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
        title: 'title',
        content: 'content',
        primaryButtonText: 'primaryButtonText',
        onPrimaryButtonSelected: () {
          count1++;
        },
        textButtonText: 'textButtonText',
        onTextButtonSelected: () {
          count2++;
        },
      );

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('textButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count1, 1);

      await widgetTester.tap(find.text('textButtonText'));
      expect(count2, 1);
    });

    testWidgets(
        'nartus alert dialog - no icon and no secondary button and no text button',
        (WidgetTester widgetTester) async {
      // given
      int count = 0;
      final NartusAlertDialog alertDialog = NartusAlertDialog(
          title: 'title',
          content: 'content',
          primaryButtonText: 'primaryButtonText',
          onPrimaryButtonSelected: () {
            count++;
          });

      await widgetTester.wrapMaterialAndPump(alertDialog);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('primaryButtonText'), findsOneWidget);
      expect(find.text('secondaryButtonText'), findsNothing);
      expect(find.text('textButtonText'), findsNothing);
      expect(find.byType(SvgPicture), findsNothing);

      await widgetTester.tap(find.text('primaryButtonText'));
      expect(count, 1);
    });
  });
}
