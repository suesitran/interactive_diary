part of 'advance_text_editor_view.dart';

const double styleButtonHeight = 40;

enum TextFormatType {
  bold(TextFormat.bold, Attribute.bold),
  italic(TextFormat.italic, Attribute.italic),
  underline(TextFormat.underline, Attribute.underline),
  highlight(TextFormat.highlight, Attribute.background),
  color(TextFormat.textColor, Attribute.color),
  bullet(TextFormat.bullet, Attribute.ul),
  numbered(TextFormat.numbered, Attribute.ol),
  strikethrough(TextFormat.strikeThrough, Attribute.strikeThrough),
  quote(TextFormat.quote, Attribute.blockQuote),
  alignLeft(TextFormat.alignLeft, Attribute.leftAlignment),
  alignCenter(TextFormat.alignCenter, Attribute.centerAlignment),
  alignRight(TextFormat.alignRight, Attribute.rightAlignment),
  alignJustify(TextFormat.alignJustify, Attribute.justifyAlignment);

  final String svgIcon;
  final Attribute attribute;

  const TextFormatType(this.svgIcon, this.attribute);

  String a11y(BuildContext context) => S.of(context).textEditorSemantic(name);
}

class StyleButton extends StatelessWidget {
  final QuillController controller;
  late final TextFormatType type;

  final ValueNotifier<bool> _isSelected = ValueNotifier(false);

  StyleButton({required this.type, required this.controller, Key? key})
      : super(key: key) {

    controller.addListener(() {
      if (_isSelected.value) {
        _isSelected.value = controller
            .getSelectionStyle()
            .attributes
            .containsKey(type.attribute.key);
      }
    });
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _isSelected,
        builder: (context, isSelected, child) => Semantics(
          label: type.a11y(context),
          onTap: () => onTap(context, isSelected),
          button: true,
          child: SizedBox(
            height: styleButtonHeight,
            child: InkWell(
              excludeFromSemantics: true,
              borderRadius: BorderRadius.circular(32),
              splashColor:
                  isSelected ? Colors.transparent : NartusColor.primaryContainer,
              onTap: () => onTap(context, isSelected),
              child: Container(
                padding: const EdgeInsets.all(NartusDimens.padding8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color:
                      isSelected ? const Color(0xFFEFEAFE) : Colors.transparent,
                ),
                child: SvgPicture.string(
                  type.svgIcon,
                  width: NartusDimens.size24,
                  height: NartusDimens.size24,
                  colorFilter: ColorFilter.mode(
                      isSelected ? NartusColor.primary : NartusColor.dark,
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      );

  void onTap(BuildContext context, bool isSelected) {
    bool newValue = !isSelected;

    _toggleAttribute(newValue);
    _updateSelected();
  }

  void _toggleAttribute(bool isSelected) {
    controller.formatSelection(
        isSelected ? type.attribute : Attribute.clone(type.attribute, null));
  }

  void _updateSelected() {
    bool newValue = !_isSelected.value;

    _isSelected.value = newValue;
  }
}

class StyleColorButton extends StyleButton {
  final ColorPickerController colorPickerController;

  StyleColorButton({
    required super.type,
    required super.controller,
    required this.colorPickerController,
    super.key,
  }) {
    colorPickerController.onColorChange.addListener(() {
      onColorChange(colorPickerController.onColorChange.value);
    });
  }

  void onColorChange(Color color) {
    String hex = _colorToHex(color);

    if (_isSelected.value) {
      controller.formatSelection(
          type == TextFormatType.highlight ? BackgroundAttribute(hex) : ColorAttribute(hex));
    }
  }

  String _colorToHex(Color color) {
    String hex = color.value.toRadixString(16);
    if (hex.startsWith('ff')) {
      hex = hex.substring(2);
    }
    hex = '#$hex';

    return hex;
  }

  // override onTap to show color picker
  @override
  void onTap(BuildContext context, bool isSelected) {
    super.onTap(context, isSelected);

    if (!isSelected) {
      // it's currently not selected, need to show color picker and change to selected now
      colorPickerController.show();
    } else {
      colorPickerController.hide();
      controller.formatSelection(Attribute.clone(type.attribute, null));
    }
  }
}

/// Group buttons implementation
///
class AttributeGroupValue extends ValueNotifier<Attribute?> {
  AttributeGroupValue() : super(null);

  void select(Attribute attribute) {
    value = attribute;
    notifyListeners();
  }

  void unselect(Attribute attribute) {
    value = null;
    notifyListeners();
  }

  bool contains(Attribute attribute) => value == attribute;
}

class StyleGroupButton extends StyleButton {
  final AttributeGroupValue attributeGroup;

  StyleGroupButton(
      {required super.type,
      required super.controller,
      required this.attributeGroup,
      super.key}) {
    attributeGroup.addListener(() {
      updateGroupSelection();
    });
  }

  @override
  void _updateSelected() {
    bool isSelected = attributeGroup.contains(type.attribute);

    if (isSelected) {
      // remove it
      attributeGroup.unselect(type.attribute);
    } else {
      attributeGroup.select(type.attribute);
    }
  }

  void updateGroupSelection() {
    bool isSelected = attributeGroup.contains(type.attribute);

    _isSelected.value = isSelected;
  }
}

class StyleListButton extends StyleGroupButton {
  StyleListButton({
    required super.type,
    required super.controller,
    required super.attributeGroup,
    super.key,
  });
}

class StyleAlignButton extends StyleGroupButton {
  StyleAlignButton(
      {required super.type,
      required super.controller,
      required super.attributeGroup,
      super.key});
}
