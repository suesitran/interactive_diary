import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets(
      'given location string, when location view rendered, then show exactly location details',
      (WidgetTester tester) async {
    const String location =
        'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia';
    const LocationView widget = LocationView(address: location, latitude: 1.0, longitude: 1.0,);

    await tester.wrapAndPump(widget);

    expect(find.byType(SvgPicture), findsOneWidget);
    SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
    expect(svgPicture.height, 15);
    expect(svgPicture.width, 13);

    expect(find.byType(Text), findsOneWidget);
    expect(
        find.text(
            'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia'),
        findsOneWidget);
  });
}
