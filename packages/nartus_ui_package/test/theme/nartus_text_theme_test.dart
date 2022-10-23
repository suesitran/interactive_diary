import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Validate [Display] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.displayLarge),
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.displayMedium),
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.displaySmall)
          ],
        ),
      );
    });

    await tester.wrapMaterialAndPump(displayTextGroup, theme: lightTheme);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));
    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize48);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwBold);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize32);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwBold);

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize24);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwBold);
  });

  testWidgets('Validate [Headline] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.headlineLarge),
            Text('Test Medium',
                key: mediumK,
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      );
    });

    await tester.wrapMaterialAndPump(displayTextGroup, theme: lightTheme);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize20);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwBold);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize18);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwBold);
  });

  testWidgets('Validate [Title] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.titleLarge),
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.titleMedium),
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
      );
    });

    await tester.wrapMaterialAndPump(displayTextGroup, theme: lightTheme);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));
    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize18);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwSemiBold);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize16);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwSemiBold);

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize14);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwSemiBold);
  });

  testWidgets('Validate [Body] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.bodyLarge),
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.bodyMedium),
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      );
    });

    await tester.wrapMaterialAndPump(displayTextGroup, theme: lightTheme);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));
    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize16);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize14);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwRegular);

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize12);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwRegular);
  });

  testWidgets('Validate [Label] text style ', (WidgetTester tester) async {
    GlobalKey mediumK = GlobalKey();
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.labelMedium),
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.labelSmall)
          ],
        ),
      );
    });

    await tester.wrapMaterialAndPump(displayTextGroup, theme: lightTheme);

    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));
    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize12);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwSemiBold);

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize10);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwSemiBold);
  });
}
