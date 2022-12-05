import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/widgets/location_view.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/widgets/widgets.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI write diary screen',
      (WidgetTester widgetTester) async {
    WriteDiaryScreen widget = WriteDiaryScreen(
      latLng: const LatLng(long: 0.0, lat: 0.0),
    );

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(NartusButton), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    expect(find.byType(LocationView), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
