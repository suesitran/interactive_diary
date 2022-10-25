import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

extension GapTestExtension on WidgetTester {
  /// Wrap inside Column to force gap renders the correct defined size
  /// Because if SizedBox's parent was Scaffold/ Material App then SizedBox will take
  /// all available space
  Future<void> wrapForceRightSizeBoxAndPump(Gap widget) async {
    await wrapMaterialAndPump(Column(
      children: <Widget>[widget],
    ));
  }
}

void main() {
  group('Test vertical gap', () {
    testWidgets('When create gap with v20, Then render SizedBox with height 20',
        (WidgetTester tester) async {
      const Gap gap = Gap.v20();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.height, 20);
    });

    testWidgets('When create gap with v16, Then render SizedBox with height 16',
        (WidgetTester tester) async {
      const Gap gap = Gap.v16();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.height, 16);
    });

    testWidgets('When create gap with v12, Then render SizedBox with height 12',
        (WidgetTester tester) async {
      const Gap gap = Gap.v12();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.height, 12);
    });

    testWidgets('When create gap with v08, Then render SizedBox with height 08',
        (WidgetTester tester) async {
      const Gap gap = Gap.v08();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.height, 08);
    });

    testWidgets('When create gap with v04, Then render SizedBox with height 04',
        (WidgetTester tester) async {
      const Gap gap = Gap.v04();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.height, 04);
    });
  });

  group('Test horizontal gap', () {
    testWidgets('When create gap with h20, Then render SizedBox with height 20',
        (WidgetTester tester) async {
      const Gap gap = Gap.h20();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.width, 20);
    });

    testWidgets('When create gap with h16, Then render SizedBox with height 16',
        (WidgetTester tester) async {
      const Gap gap = Gap.h16();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.width, 16);
    });

    testWidgets('When create gap with h12, Then render SizedBox with height 12',
        (WidgetTester tester) async {
      const Gap gap = Gap.h12();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.width, 12);
    });

    testWidgets('When create gap with h08, Then render SizedBox with height 08',
        (WidgetTester tester) async {
      const Gap gap = Gap.h08();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.width, 08);
    });

    testWidgets('When create gap with h04, Then render SizedBox with height 04',
        (WidgetTester tester) async {
      const Gap gap = Gap.h04();

      await tester.wrapForceRightSizeBoxAndPump(gap);

      final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(size.width, 04);
    });
  });
}
