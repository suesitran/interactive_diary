import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_display_content_cubit.dart';
import 'package:interactive_diary/features/diary_detail/picture_diary_detail_screen.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../widget_tester_extension.dart';
import 'picture_diary_detail_screen_test.mocks.dart';

@GenerateMocks([
  DiaryDisplayContentCubit,
  StorageService,
])
void main() {
  initializeDateFormatting();

  final MockDiaryDisplayContentCubit mockDiaryDisplayContentCubit =
      MockDiaryDisplayContentCubit();
  final MockStorageService mockStorageService = MockStorageService();

  setUpAll(() {
    ServiceLocator.instance
        .registerSingleton<StorageService>(mockStorageService);
  });

  setUp(() {
    when(mockDiaryDisplayContentCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(DiaryDisplayContentInitial()));
    when(mockDiaryDisplayContentCubit.state)
        .thenAnswer((realInvocation) => DiaryDisplayContentInitial());
  });

  tearDown(() {
    reset(mockDiaryDisplayContentCubit);
    reset(mockStorageService);
  });

  testWidgets('Verify Picture diary details screen', (widgetTester) async {
    const Widget widget = PictureDiaryDetailScreen(
      dateTime: 123354,
      countryCode: 'US',
      postalCode: '123456',
    );

    final DiaryDisplayContent content = DiaryDisplayContent(
      userDisplayName: 'userDisplayName',
      dateTime: DateTime.now(),
      userPhotoUrl: 'userPhotoUrl',
      plainText: 'plainText',
      countryCode: 'countryCode',
      postalCode: 'postalCode',
      imageUrl: ['imageUrl'],
    );
    final DiaryDisplayContentState state = DiaryDisplayContentSuccess(content);

    when(mockDiaryDisplayContentCubit.state).thenAnswer((_) => state);
    when(mockDiaryDisplayContentCubit.stream)
        .thenAnswer((_) => Stream.value(state));

    final diary = Diary(
      title: 'title',
      countryCode: 'AU',
      postalCode: '2345',
      addressLine: '123 heaven street',
      latLng: const LatLng(lat: 0.0, long: 0.0),
      timestamp: 123456789,
      update: 123456789,
      contents: [TextDiary(description: '[{"insert":"description\\n"}]')],
    );

    when(mockStorageService.getDiary(
      dateTime: anyNamed('dateTime'),
      countryCode: anyNamed('countryCode'),
      postalCode: anyNamed('postalCode'),
      month: anyNamed('month'),
    )).thenAnswer((_) => Future.value(diary));

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(
          widget,
        ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(CircleButton), findsOneWidget);
    expect(find.byType(ActivityFeedCard), findsOneWidget);
  });

  testWidgets(
      'given picture diary detail screen is display '
      'when tap on close button , '
      'then picture diary detail screen will be back to previous screen',
      (widgetTester) async {
    const Widget widget = PictureDiaryDetailScreen(
      dateTime: 123354,
      countryCode: 'US',
      postalCode: '123456',
    );

    final DiaryDisplayContent content = DiaryDisplayContent(
      userDisplayName: 'userDisplayName',
      dateTime: DateTime.now(),
      userPhotoUrl: 'userPhotoUrl',
      plainText: 'plainText',
      countryCode: 'countryCode',
      postalCode: 'postalCode',
      imageUrl: ['imageUrl'],
    );
    final DiaryDisplayContentState state = DiaryDisplayContentSuccess(content);

    when(mockDiaryDisplayContentCubit.state).thenAnswer((_) => state);
    when(mockDiaryDisplayContentCubit.stream)
        .thenAnswer((_) => Stream.value(state));

    final diary = Diary(
      title: 'title',
      countryCode: 'AU',
      postalCode: '2345',
      addressLine: '123 heaven street',
      latLng: const LatLng(lat: 0.0, long: 0.0),
      timestamp: 123456789,
      update: 123456789,
      contents: [TextDiary(description: '[{"insert":"description\\n"}]')],
    );

    when(mockStorageService.getDiary(
      dateTime: anyNamed('dateTime'),
      countryCode: anyNamed('countryCode'),
      postalCode: anyNamed('postalCode'),
      month: anyNamed('month'),
    )).thenAnswer((_) => Future.value(diary));

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(
          widget,
        ));

    final closeButton = find.byType(CircleButton);

    expect(closeButton, findsOneWidget);

    //test pressed button
    await widgetTester.tap(closeButton);
    await widgetTester.pumpAndSettle();
    expect(find.byType(PictureDiaryDetailScreen), findsNothing);
  });

  // will be updated in the future
  testWidgets(
      'given get diary not found,'
      'when go to picture diary details screen , '
      'then show blank screen', (widgetTester) async {
    const Widget widget = PictureDiaryDetailScreen(
      dateTime: 123354,
      countryCode: 'US',
      postalCode: '123456',
    );

    final DiaryDisplayContentState state = DiaryDisplayContentNotFound();

    when(mockDiaryDisplayContentCubit.state).thenAnswer((_) => state);
    when(mockDiaryDisplayContentCubit.stream)
        .thenAnswer((_) => Stream.value(state));

    when(mockStorageService.getDiary(
      dateTime: anyNamed('dateTime'),
      countryCode: anyNamed('countryCode'),
      postalCode: anyNamed('postalCode'),
      month: anyNamed('month'),
    )).thenAnswer((_) => Future.value(null));

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(
          widget,
        ));

    expect(find.byType(Container), findsOneWidget);
  });
}
