import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/writediary/bloc/write_diary_cubit.dart';
import 'package:interactive_diary/features/writediary/widgets/advance_text_editor_view.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/widgets/widgets.dart';

import '../../widget_tester_extension.dart';
import 'write_diary_screen_test.mocks.dart';

@GenerateMocks(<Type>[WriteDiaryCubit, StorageService])
void main() {
  final MockWriteDiaryCubit writeDiaryCubit = MockWriteDiaryCubit();

  setUpAll(() => ServiceLocator.instance.registerSingleton<StorageService>(MockStorageService()));

  testWidgets('verify UI write diary screen',
      (WidgetTester widgetTester) async {
    WriteDiaryBody widget = WriteDiaryBody(
      latLng: const LatLng(long: 0.0, lat: 0.0),
      address: null,
      business: null,
    );

    when(writeDiaryCubit.state).thenAnswer((_) => WriteDiaryInitial());
    when(writeDiaryCubit.stream).thenAnswer((_) => Stream.value(WriteDiaryInitial()));

    await widgetTester.blocWrapAndPump<WriteDiaryCubit>(writeDiaryCubit, widget);

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
    expect(find.byType(AdvanceTextEditorView), findsOneWidget);
  });

  testWidgets('given text field is empty, then Save button should be disable',
      (WidgetTester widgetTester) async {
    final WriteDiaryBody widget = WriteDiaryBody(
      latLng: const LatLng(long: 0.0, lat: 0.0),
      address: null,
      business: null,
    );

    when(writeDiaryCubit.stream).thenAnswer((_) => Stream.value(WriteDiaryInitial()));
    when(writeDiaryCubit.state).thenAnswer((_) => WriteDiaryInitial());
    await widgetTester.blocWrapAndPump<WriteDiaryCubit>(writeDiaryCubit, widget);

    // there's no string in text field, Save button should be disabled
    NartusButton saveButton = widgetTester.widget(find.ancestor(
        of: find.byType(Text), matching: find.byType(NartusButton)));
    expect(saveButton.onPressed, isNull);
  });

  testWidgets('given text field has text, then save button should be enabled',
      (WidgetTester widgetTester) async {
    final WriteDiaryBody widget = WriteDiaryBody(
      latLng: const LatLng(long: 0.0, lat: 0.0),
      address: null,
      business: null,
    );

    when(writeDiaryCubit.state).thenAnswer((_) => WriteDiaryInitial());
    when(writeDiaryCubit.stream).thenAnswer((_) => Stream.value(WriteDiaryInitial()));

    await widgetTester.blocWrapAndPump<WriteDiaryCubit>(writeDiaryCubit, widget);

    // enter text, and expect Save button to be enabled
    QuillEditor textField =
        widgetTester.widget(find.byType(QuillEditor)) as QuillEditor;
    textField.controller.compose(
        Delta.fromJson(jsonDecode('[{"insert":"sample text\\n"}]')),
        const TextSelection(baseOffset: 0, extentOffset: 0),
        ChangeSource.REMOTE);
    expect(textField.controller.document.toPlainText(), 'sample text\n\n');
    await widgetTester.pump();

    // get SaveButton, and check
    NartusButton saveButton = widgetTester.widget(find.ancestor(
        of: find.byType(Text), matching: find.byType(NartusButton)));
    expect(saveButton.onPressed, isNotNull);
  });

  testWidgets(
      'given diary text not empty, when tap on save, then send RequestSaveTextDiaryEvent',
      (WidgetTester widgetTester) async {
    final WriteDiaryBody widget = WriteDiaryBody(
      latLng: const LatLng(long: 0.0, lat: 0.0),
      address: null,
      business: null,
    );

    when(writeDiaryCubit.state).thenAnswer((_) => WriteDiaryInitial());
    when(writeDiaryCubit.stream)
        .thenAnswer((_) => Stream<WriteDiaryState>.value(WriteDiaryInitial()));

    await widgetTester.blocWrapAndPump<WriteDiaryCubit>(
        writeDiaryCubit, widget);

    // enter text, and expect Save button to be enabled
    QuillEditor textField =
        widgetTester.widget(find.byType(QuillEditor)) as QuillEditor;
    textField.controller.compose(
        Delta.fromJson(jsonDecode('[{"insert":"sample text\\n"}]')),
        const TextSelection(baseOffset: 0, extentOffset: 0),
        ChangeSource.REMOTE);
    expect(textField.controller.document.toPlainText(), 'sample text\n\n');
    await widgetTester.pump();

    // tap on save button
    await widgetTester.tap(find.ancestor(
        of: find.text('Save'), matching: find.byType(NartusButton)));
    await widgetTester.pumpAndSettle();

    // expect
    verify(writeDiaryCubit.saveTextDiary(
            title: anyNamed('title'),
            latLng: anyNamed('latLng'),
            textContent: anyNamed('textContent')))
        .called(1);
  });
}
