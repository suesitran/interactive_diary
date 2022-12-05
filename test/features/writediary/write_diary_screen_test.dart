import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/storage/storage_bloc.dart';
import 'package:interactive_diary/widgets/location_view.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/widgets/widgets.dart';

import '../../widget_tester_extension.dart';
import 'write_diary_screen_test.mocks.dart';

@GenerateMocks([StorageBloc])
void main() {
  final MockStorageBloc storageBloc = MockStorageBloc();

  testWidgets('verify UI write diary screen',
      (WidgetTester widgetTester) async {
    WriteDiaryScreen widget = WriteDiaryScreen(
      latLng: const LatLng(long: 0.0, lat: 0.0),
    );

    when(storageBloc.state).thenAnswer((_) => StorageInitial());
    when(storageBloc.stream)
        .thenAnswer((_) => Stream<StorageState>.value(StorageInitial()));

    await widgetTester.blocWrapAndPump<StorageBloc>(storageBloc, widget);

    // this is Back button in AppBar
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(SvgPicture)),
        findsOneWidget);
    expect(
        find.ancestor(
            of: find.byType(SvgPicture), matching: find.byType(NartusButton)),
        findsOneWidget);

    // this is Save button in AppBar
    expect(
        find.ancestor(
            of: find.byType(Text), matching: find.byType(NartusButton)),
        findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    expect(find.byType(LocationView), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('given text field is empty, then Save button should be disable',
      (WidgetTester widgetTester) async {
    WriteDiaryScreen widget = WriteDiaryScreen(
      latLng: const LatLng(long: 0.0, lat: 0.0),
    );

    when(storageBloc.state).thenAnswer((_) => StorageInitial());
    when(storageBloc.stream)
        .thenAnswer((_) => Stream<StorageState>.value(StorageInitial()));

    await widgetTester.blocWrapAndPump<StorageBloc>(storageBloc, widget);

    // there's no string in text field, Save button should be disabled
    NartusButton saveButton = widgetTester.widget(find.ancestor(
        of: find.byType(Text), matching: find.byType(NartusButton)));
    expect(saveButton.onPressed, isNull);
  });

  testWidgets('given text field has text, then save button should be enabled',
      (WidgetTester widgetTester) async {
    WriteDiaryScreen widget = WriteDiaryScreen(
      latLng: const LatLng(long: 0.0, lat: 0.0),
    );

    when(storageBloc.state).thenAnswer((_) => StorageInitial());
    when(storageBloc.stream)
        .thenAnswer((_) => Stream<StorageState>.value(StorageInitial()));

    await widgetTester.blocWrapAndPump<StorageBloc>(storageBloc, widget);

    // enter text, and expect Save button to be enabled
    await widgetTester.enterText(find.byType(TextField), 'sample text');
    TextField textField =
        widgetTester.widget(find.byType(TextField)) as TextField;
    expect(textField.controller?.text, 'sample text');
    await widgetTester.pump();

    // get SaveButton, and check
    NartusButton saveButton = widgetTester.widget(find.ancestor(
        of: find.byType(Text), matching: find.byType(NartusButton)));
    expect(saveButton.onPressed, isNotNull);
  });
}
