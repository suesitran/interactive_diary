import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets(
      'given user name and user photo,'
      'when widget is displayed,'
      'then show correct name and user photo', (WidgetTester tester) async {
    String userDisplayName = 'Hoang Nguyen';
    String userPhotoUrl =
        'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';
    String dateTime = '11 Jun, 2023 at 23:52 PM';

    Widget widget = ActivityFeedCard(
      avatarPath: userPhotoUrl,
      displayName: userDisplayName,
      dateTime: dateTime,
    );

    await mockNetworkImagesFor(() => tester.wrapMaterialAndPump(widget));

    expect(find.text('Hoang Nguyen'), findsOneWidget);
    expect(find.text('11 Jun, 2023 at 23:52 PM'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets(
      'given user name and user photo is null,'
      'when widget is displayed,'
      'then show default name and default photo', (WidgetTester tester) async {
    String dateTime = '11 Jun, 2023 at 23:52 PM';

    Widget widget = ActivityFeedCard(
      avatarPath: null,
      displayName: null,
      dateTime: dateTime,
    );

    await mockNetworkImagesFor(() => tester.wrapMaterialAndPump(widget));

    expect(find.text('Guest'), findsOneWidget);
    expect(find.text('11 Jun, 2023 at 23:52 PM'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets(
      'given user name and user photo are not null,'
      'when widget is displayed,'
      'then show name and user photo', (WidgetTester tester) async {
    String dateTime = '11 Jun, 2023 at 23:52 PM';

    Widget widget = ActivityFeedCard(
      avatarPath: 'avatarPath',
      displayName: 'Display Name',
      dateTime: dateTime,
    );

    await mockNetworkImagesFor(() => tester.wrapMaterialAndPump(widget));

    expect(find.text('Display Name'), findsOneWidget);
    expect(find.text('11 Jun, 2023 at 23:52 PM'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
