import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/widgets/map_type/map_type_bottom_sheet.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  final List<String> mapTypeName = ['Default', 'Satellite', 'Terrain'];

  testWidgets('verify generic components of MapTypeBottomSheet',
      (widgetTester) async {
    const Widget widget = MapTypeBottomSheet(
      currentType: MapType.normal,
    );

    await widgetTester.wrapAndPump(widget);

    expect(find.text('Map Type'), findsOneWidget);
    expect(find.byType(MapTypeDisplay), findsNWidgets(3));

    Iterable<MapTypeDisplay> mapTypeDisplays =
        widgetTester.widgetList(find.byType(MapTypeDisplay));

    int index = 0;
    for (MapTypeDisplay display in mapTypeDisplays) {
      expect(display.name, mapTypeName[index]);
      index++;
    }
  });

  testWidgets(
      'given current type is normal, when load MapTypeBottomSheet, then MapType default is selected',
      (widgetTester) async {
    const Widget widget = MapTypeBottomSheet(
      currentType: MapType.normal,
    );

    await widgetTester.wrapAndPump(widget);

    MapTypeDisplay display = widgetTester.widget(find.ancestor(
        of: find.text('Default'), matching: find.byType(MapTypeDisplay)));
    expect(display.isSelected, true);
  });

  testWidgets(
      'given current type is satellite, when load MapTypeBottomSheet, then MapType satellite is selected',
      (widgetTester) async {
    const Widget widget = MapTypeBottomSheet(
      currentType: MapType.satellite,
    );

    await widgetTester.wrapAndPump(widget);

    MapTypeDisplay display = widgetTester.widget(find.ancestor(
        of: find.text('Satellite'), matching: find.byType(MapTypeDisplay)));
    expect(display.isSelected, true);
  });

  testWidgets(
      'given current type is terrain, when load MapTypeBottomSheet, then MapType terrain is selected',
      (widgetTester) async {
    const Widget widget = MapTypeBottomSheet(
      currentType: MapType.terrain,
    );

    await widgetTester.wrapAndPump(widget);

    MapTypeDisplay display = widgetTester.widget(find.ancestor(
        of: find.text('Terrain'), matching: find.byType(MapTypeDisplay)));
    expect(display.isSelected, true);
  });
}
