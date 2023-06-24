import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../widget_tester_extension.dart';

void main() {
  String userDisplayName = 'Guest';
  String userPhotoUrl = 'assets/images/guest.svg';
  String dateTime = '15 May, 2023 at 08:41 AM';

  testWidgets('verify UI Diary Header Appbar', (WidgetTester tester) async {
    Widget widget = DiaryHeaderAppbar(
        avatarPath: userPhotoUrl,
        displayName: userDisplayName,
        dateTime: dateTime,
        icon: 'assets/facebook.svg');
    await mockNetworkImagesFor(() => tester.wrapMaterialAndPump(widget));

    final Finder displayNameFind = find.text('Guest');
    final Finder dateTimeFind = find.text('15 May, 2023 at 08:41 AM');
    final Finder svgPicture = find.byType(SvgPicture);

    expect(displayNameFind, findsOneWidget);
    expect(dateTimeFind, findsOneWidget);
    expect(svgPicture, findsOneWidget);
  });
}
