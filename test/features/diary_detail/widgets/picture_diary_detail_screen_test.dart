import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_display_content_cubit.dart';
import 'package:interactive_diary/features/diary_detail/widgets/picture_diary_detail_screen.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../widget_tester_extension.dart';
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
    final Widget widget = PictureDiaryDetailScreen(
      imageUrl: '',
      displayName: null,
      photoUrl: null,
      dateTime: DateTime(2022, 10, 20, 10, 18, 23),
    );

    final DiaryDisplayContentState state = ImageDiaryContent(
        imagePath: 'imagePath',
        dateTime: DateTime(2022, 10, 20, 10, 18, 23),
        displayName: 'displayName',
        photoUrl: 'photoUrl');

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
    final Widget widget = PictureDiaryDetailScreen(
      imageUrl: '',
      displayName: null,
      photoUrl: null,
      dateTime: DateTime(2022, 10, 20, 10, 18, 23),
    );

    final DiaryDisplayContentState state = ImageDiaryContent(
        imagePath: 'imagePath',
        dateTime: DateTime(2022, 10, 20, 10, 18, 23),
        displayName: 'displayName',
        photoUrl: 'photoUrl');

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
}
