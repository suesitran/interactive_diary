import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  const String mockAddress =
      'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia';
  testWidgets(
      'given location string, '
      'when location view rendered, '
      'then show exactly location details', (WidgetTester tester) async {
    const LocationView widget = LocationView(
      locationIconSvg: 'assets/facebook.svg',
      address: mockAddress,
      latitude: 1.0,
      longitude: 1.0,
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(SvgPicture), findsOneWidget);
    SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
    expect(svgPicture.height, 15);
    expect(svgPicture.width, 13);

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(mockAddress), findsOneWidget);
  });

  testWidgets(
      'given the location is a business location with valid address, '
      'when location view rendered, '
      'then show business name above the address', (WidgetTester tester) async {
    final LocationView widget = LocationView(
      key: GlobalKey(),
      businessName: 'The Coffee Shop',
      address: mockAddress,
      latitude: 1.0,
      longitude: 1.0,
    );

    await tester.wrapMaterialAndPump(widget);

    final Finder businessName = find.text('The Coffee Shop');
    final Finder address = find.text(mockAddress);

    expect(businessName, findsOneWidget);
    expect(address, findsOneWidget);
  });

  testWidgets(
      'given the location is not a business location valid address, '
      'when location view rendered, '
      'then only show the address', (WidgetTester tester) async {
    const LocationView widget = LocationView(
      address: mockAddress,
      latitude: 1.0,
      longitude: 1.0,
    );

    await tester.wrapMaterialAndPump(widget);

    final Finder businessName = find.text('The Coffee Shop');
    final Finder address = find.text(mockAddress);

    expect(businessName, findsNothing);
    expect(address, findsOneWidget);
  });

  testWidgets(
      'given the location is not a valid address, '
      'when location view rendered, '
      'then only show the lat & long coordination',
      (WidgetTester tester) async {
    const LocationView widget = LocationView(
      latitude: 1.0,
      longitude: 1.0,
    );

    await tester.wrapMaterialAndPump(widget);

    final Finder businessName = find.text('The Coffee Shop');
    final Finder address = find.text(mockAddress);
    final Finder coordinates = find.text('(1.0, 1.0)');

    expect(businessName, findsNothing);
    expect(address, findsNothing);
    expect(coordinates, findsOneWidget);
  });

  testWidgets(
      'given the location is not a valid address, '
      'when location view rendered, '
      'then only show the lat & long coordination',
      (WidgetTester tester) async {
    const LocationView widget = LocationView(
      latitude: 1.0,
      longitude: 1.0,
    );

    await tester.wrapMaterialAndPump(widget);

    final Finder businessName = find.text('The Coffee Shop');
    final Finder address = find.text(mockAddress);
    final Finder coordinates = find.text('(1.0, 1.0)');

    expect(businessName, findsNothing);
    expect(address, findsNothing);
    expect(coordinates, findsOneWidget);
  });

  testWidgets(
      'given the location have business name & address, '
      'when location view rendered, '
      'then screen reader will read name & address but will not read coordinate',
      (WidgetTester tester) async {
    const LocationView widget = LocationView(
      businessName: 'Ben Thanh Market',
      address:
          'Lê Lợi, Phường Bến Thành, Quận 1, Thành phố Hồ Chí Minh, Vietnam',
      latitude: 1.0,
      longitude: 1.0,
      semanticBusinessName: 'Business name semantic',
      semanticAddress: 'Address semantic',
    );

    await tester.wrapMaterialAndPump(widget);

    /// Note : We use RegExp here because in some case framework may combines
    /// semantic labels together into a long text, so we should use RegExp to find
    /// the text that we want
    /// Ref : https://api.flutter.dev/flutter/flutter_test/CommonFinders/bySemanticsLabel.html
    final Finder businessName =
        find.bySemanticsLabel(RegExp(r'Business name semantic'));
    final Finder address = find.bySemanticsLabel(RegExp(r'Address semantic'));
    final Finder coordinates = find.bySemanticsLabel('Coordinate semantic');

    expect(businessName, findsOneWidget);
    expect(address, findsOneWidget);
    expect(coordinates, findsNothing);
  });

  testWidgets(
      'given the location is invalid, '
      'when location view rendered, '
      'then screen reader only read the coordinate',
      (WidgetTester tester) async {
    const LocationView widget = LocationView(
      latitude: 1.0,
      longitude: 1.0,
      semanticBusinessName: 'Business name semantic',
      semanticAddress: 'Address semantic',
    );

    await tester.wrapMaterialAndPump(widget);

    final Finder businessName = find.bySemanticsLabel('Business name semantic');
    final Finder address = find.bySemanticsLabel('Address semantic');
    final Finder coordinates =
        find.bySemanticsLabel('Location at latitude 1.0 and longitude 1.0');

    expect(businessName, findsNothing);
    expect(address, findsNothing);
    expect(coordinates, findsOneWidget);
  });
}
