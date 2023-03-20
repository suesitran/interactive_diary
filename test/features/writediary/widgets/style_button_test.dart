import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/writediary/widgets/advance_text_editor_view.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_tester_extension.dart';

class MockQuillController extends Mock implements QuillController {}

void main() {
  final QuillController controller = QuillController.basic();
  final ColorPickerController colorPickerController = ColorPickerController();

  testWidgets('verify generic button layout', (widgetTester) async {
    StyleButton styleButton =
        StyleButton(type: TextFormatType.bold, controller: controller);

    await widgetTester.wrapAndPump(styleButton);

    // verify it contains a Semantic, SizedBox, Inkwell, and SvgPicture
    // Semantic is descendant of StyleButton and ancestor of SizedBox
    expect(
        find.descendant(
            of: find.byType(StyleButton),
            matching: find.ancestor(
                of: find.byType(SizedBox),
                matching: find.bySemanticsLabel('Bold'))),
        findsOneWidget);

    // SizedBox is a descendant of StyleButton and ancestor of Inkwell
    expect(
        find.descendant(
            of: find.byType(StyleButton),
            matching: find.ancestor(
                of: find.byType(InkWell), matching: find.byType(SizedBox))),
        findsOneWidget);

    // SizedBox is a descendant of StyleButton and ancestor of Inkwell
    expect(
        find.descendant(
            of: find.byType(StyleButton),
            matching: find.ancestor(
                of: find.byType(InkWell), matching: find.byType(SizedBox))),
        findsOneWidget);

    // InkWell is descendant of SizedBox and ancestor of Container
    expect(
        find.descendant(
            of: find.byType(SizedBox),
            matching: find.ancestor(
                of: find.byType(Container), matching: find.byType(InkWell))),
        findsOneWidget);

    // SvgPicture is descendant of InkWell
    expect(
        find.descendant(
            of: find.byType(InkWell), matching: find.byType(SvgPicture)),
        findsOneWidget);

    // verify SizedBox height
    SizedBox sizedBox = widgetTester.widget(find.descendant(
        of: find.byType(StyleButton),
        matching: find.ancestor(
            of: find.byType(InkWell), matching: find.byType(SizedBox))));

    expect(sizedBox.height, 40);

    // verify InkWell border radius and splash color
    InkWell inkWell = widgetTester.widget(find.descendant(
        of: find.byType(SizedBox),
        matching: find.ancestor(
            of: find.byType(Container), matching: find.byType(InkWell))));
    expect(inkWell.borderRadius?.bottomLeft.x, 32);
    expect(inkWell.borderRadius?.bottomLeft.y, 32);
    expect(inkWell.borderRadius?.bottomRight.x, 32);
    expect(inkWell.borderRadius?.bottomRight.y, 32);
    expect(inkWell.borderRadius?.topLeft.x, 32);
    expect(inkWell.borderRadius?.topLeft.y, 32);
    expect(inkWell.borderRadius?.topRight.x, 32);
    expect(inkWell.borderRadius?.topRight.y, 32);
    expect(inkWell.splashColor, const Color(0xffefeafe));
  });

  group('verify icon data', () {
    testWidgets('verify icon data - bold', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.bold, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.bold);
    });

    testWidgets('verify icon data - italic', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.italic, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.italic);
    });

    testWidgets('verify icon data - underline', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.underline, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.underline);
    });

    testWidgets('verify icon data - highlight', (widgetTester) async {
      StyleButton styleButton = StyleColorButton(
        type: TextFormatType.highlight,
        controller: controller,
        colorPickerController: colorPickerController,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.highlight);
    });

    testWidgets('verify icon data - color', (widgetTester) async {
      StyleButton styleButton = StyleColorButton(
        type: TextFormatType.color,
        controller: controller,
        colorPickerController: colorPickerController,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.textColor);
    });

    testWidgets('verify icon data - strike through', (widgetTester) async {
      StyleButton styleButton = StyleButton(
          type: TextFormatType.strikethrough, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.strikeThrough);
    });

    testWidgets('verify icon data - quote', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.quote, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.quote);
    });

    testWidgets('verify icon data - align left', (widgetTester) async {
      StyleButton styleButton = StyleAlignButton(
        type: TextFormatType.alignLeft,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.alignLeft);
    });

    testWidgets('verify icon data - align right', (widgetTester) async {
      StyleButton styleButton = StyleAlignButton(
        type: TextFormatType.alignRight,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.alignRight);
    });

    testWidgets('verify icon data - align center', (widgetTester) async {
      StyleButton styleButton = StyleAlignButton(
        type: TextFormatType.alignCenter,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.alignCenter);
    });

    testWidgets('verify icon data - align justify', (widgetTester) async {
      StyleButton styleButton = StyleAlignButton(
        type: TextFormatType.alignJustify,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.alignJustify);
    });

    testWidgets('verify icon data - bullet', (widgetTester) async {
      StyleButton styleButton = StyleListButton(
        type: TextFormatType.bullet,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.bullet);
    });

    testWidgets('verify icon data - numbered', (widgetTester) async {
      StyleButton styleButton = StyleListButton(
        type: TextFormatType.numbered,
        controller: controller,
      );
      await widgetTester.wrapAndPump(styleButton);

      SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgStringLoader>());

      SvgStringLoader stringLoader = svgPicture.bytesLoader as SvgStringLoader;
      expect(stringLoader.provideSvg(null), TextFormat.numbered);
    });
  });

  group('verify selection update when controller data change', () {
    testWidgets('verify icon background color when quill attribute update',
        (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.bold, controller: controller);
      await widgetTester.wrapAndPump(styleButton);

      // container has transparent background
      Container unselected = widgetTester.widget(find.descendant(
          of: find.byType(SizedBox), matching: find.byType(Container)));
      expect(unselected.decoration, isA<BoxDecoration>());
      BoxDecoration unselectedDecoration =
          unselected.decoration as BoxDecoration;
      expect(unselectedDecoration.color, Colors.transparent);

      await widgetTester.tap(find.byType(StyleButton));
      // container has color background
      Container selected = widgetTester.widget(find.descendant(
          of: find.byType(SizedBox), matching: find.byType(Container)));
      expect(selected.decoration, isA<BoxDecoration>());
      BoxDecoration selectedDecoration = selected.decoration as BoxDecoration;
      expect(selectedDecoration.color, Colors.transparent);

      // remove this attribute from selection
      controller.formatSelection(Attribute.clone(Attribute.bold, null));
      controller.notifyListeners();

      // expect background to be transparent
      Container afterUnselect = widgetTester.widget(find.descendant(
          of: find.byType(SizedBox), matching: find.byType(Container)));
      expect(afterUnselect.decoration, isA<BoxDecoration>());
      BoxDecoration afterUnselectDeco =
          afterUnselect.decoration as BoxDecoration;
      expect(afterUnselectDeco.color, Colors.transparent);
    });

    testWidgets(
        'verify color selection when color is picked from color picker - background color',
        (widgetTester) async {
      final QuillController controller = QuillController.basic();

      StyleColorButton styleButton = StyleColorButton(
        type: TextFormatType.highlight,
        controller: controller,
        colorPickerController: colorPickerController,
      );
      await widgetTester.wrapAndPump(styleButton);
      await widgetTester.tap(find.byType(StyleColorButton));

      colorPickerController.onColorChange.value = const Color(0xff123456);
      colorPickerController.onColorChange.notifyListeners();

      expect(
          controller
              .getSelectionStyle()
              .attributes
              .containsKey(Attribute.background.key),
          true);
      Attribute? attribute =
          controller.getSelectionStyle().attributes[Attribute.background.key];
      expect(attribute, isNotNull);
      expect(attribute, isA<BackgroundAttribute>());
      expect(attribute?.value, '#123456');
    });

    testWidgets(
        'verify color selection when color is picked from color picker - text color',
        (widgetTester) async {
      final QuillController controller = QuillController.basic();

      StyleColorButton styleButton = StyleColorButton(
        type: TextFormatType.color,
        controller: controller,
        colorPickerController: colorPickerController,
      );
      await widgetTester.wrapAndPump(styleButton);
      await widgetTester.tap(find.byType(StyleColorButton));

      colorPickerController.onColorChange.value = const Color(0xff123456);
      colorPickerController.onColorChange.notifyListeners();

      expect(
          controller
              .getSelectionStyle()
              .attributes
              .containsKey(Attribute.color.key),
          true);
      Attribute? attribute =
          controller.getSelectionStyle().attributes[Attribute.color.key];
      expect(attribute, isNotNull);
      expect(attribute, isA<ColorAttribute>());
      expect(attribute?.value, '#123456');
    });
  });

  group('verify semantic label', () {
    testWidgets('bold icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.bold, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Bold'))),
          findsOneWidget);

      Semantics semantics = widgetTester.widget(find.bySemanticsLabel('Bold'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('italic icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.italic, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Italic'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Italic'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('underline icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.underline, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Underline'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Underline'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('highlight icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.highlight, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Highlight'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Highlight'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('color icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.color, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Font Color'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Font Color'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('bullet icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.bullet, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Bullet List'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Bullet List'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('numbered icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.numbered, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Number List'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Number List'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('strikethrough icon', (widgetTester) async {
      StyleButton styleButton = StyleButton(
          type: TextFormatType.strikethrough, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Strikethrough'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Strikethrough'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('quote icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.quote, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Quote'))),
          findsOneWidget);

      Semantics semantics = widgetTester.widget(find.bySemanticsLabel('Quote'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('left alignment icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.alignLeft, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Align Left'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Align Left'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('right alignment icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.alignRight, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Align Right'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Align Right'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('center alignment icon', (widgetTester) async {
      StyleButton styleButton =
          StyleButton(type: TextFormatType.alignCenter, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Align Center'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Align Center'));
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('Justify alignment icon', (widgetTester) async {
      StyleButton styleButton = StyleButton(
          type: TextFormatType.alignJustify, controller: controller);

      await widgetTester.wrapAndPump(styleButton);

      expect(
          find.descendant(
              of: find.byType(StyleButton),
              matching: find.ancestor(
                  of: find.byType(SizedBox),
                  matching: find.bySemanticsLabel('Align Justify'))),
          findsOneWidget);

      Semantics semantics =
          widgetTester.widget(find.bySemanticsLabel('Align Justify'));
      expect(semantics.properties.button, isTrue);
    });
  });

  testWidgets('verify semantic onTap action', (widgetTester) async {
    StyleButton styleButton =
        StyleButton(type: TextFormatType.bold, controller: controller);

    await widgetTester.wrapAndPump(styleButton);

    expect(
        find.descendant(
            of: find.byType(StyleButton),
            matching: find.ancestor(
                of: find.byType(SizedBox),
                matching: find.bySemanticsLabel('Bold'))),
        findsOneWidget);

    // container has transparent background
    Container unselected = widgetTester.widget(find.descendant(
        of: find.byType(SizedBox), matching: find.byType(Container)));
    expect(unselected.decoration, isA<BoxDecoration>());
    BoxDecoration unselectedDecoration = unselected.decoration as BoxDecoration;
    expect(unselectedDecoration.color, Colors.transparent);

    await widgetTester.tap(find.descendant(
        of: find.byType(StyleButton),
        matching: find.ancestor(
            of: find.byType(SizedBox),
            matching: find.bySemanticsLabel('Bold'))));

    // container has color background
    Container selected = widgetTester.widget(find.descendant(
        of: find.byType(SizedBox), matching: find.byType(Container)));
    expect(selected.decoration, isA<BoxDecoration>());
    BoxDecoration selectedDecoration = selected.decoration as BoxDecoration;
    expect(selectedDecoration.color, Colors.transparent);
  });
}
