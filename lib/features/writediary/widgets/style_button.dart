part of 'advance_text_editor_view.dart';

const double styleButtonHeight = 40;

class StyleButton extends StatelessWidget {
  final Attribute attribute;
  final QuillController controller;

  final ValueNotifier<bool> _isSelected = ValueNotifier(false);

  StyleButton({required this.attribute, required this.controller, Key? key})
      : super(key: key) {
    controller.addListener(() {
      if (_isSelected.value) {
        _isSelected.value = controller
            .getSelectionStyle()
            .attributes
            .containsKey(attribute.key);
      }
    });
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _isSelected,
        builder: (context, isSelected, child) => SizedBox(
          height: styleButtonHeight,
          child: InkWell(
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
                _getIconForAttribute(attribute),
                width: NartusDimens.size24,
                height: NartusDimens.size24,
                colorFilter: ColorFilter.mode(
                    isSelected ? NartusColor.primary : NartusColor.dark,
                    BlendMode.srcIn),
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
        isSelected ? attribute : Attribute.clone(attribute, null));
  }

  void _updateSelected() {
    bool newValue = !_isSelected.value;

    _isSelected.value = newValue;
  }

  String _getIconForAttribute(Attribute attribute) {
    if (attribute is BoldAttribute) {
      return TextFormat.bold;
    }

    if (attribute is ItalicAttribute) {
      return TextFormat.italic;
    }

    if (attribute is UnderlineAttribute) {
      return TextFormat.underline;
    }

    if (attribute is StrikeThroughAttribute) {
      return TextFormat.strikeThrough;
    }

    if (attribute is BlockQuoteAttribute) {
      return TextFormat.quote;
    }

    return '';
  }
}

class StyleColorButton extends StyleButton {
  final ColorPickerController colorPickerController;
  final bool background;

  StyleColorButton({
    required super.attribute,
    required super.controller,
    required this.colorPickerController,
    super.key,
  })  : assert(
            attribute is! ColorAttribute || attribute is! BackgroundAttribute),
        background = attribute is BackgroundAttribute {
    colorPickerController.onColorChange.addListener(() {
      onColorChange(colorPickerController.onColorChange.value);
    });
  }

  void onColorChange(Color color) {
    String hex = _colorToHex(color);

    if (_isSelected.value) {
      controller.formatSelection(
          background ? BackgroundAttribute(hex) : ColorAttribute(hex));
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

  @override
  String _getIconForAttribute(Attribute attribute) {
    if (attribute is ColorAttribute) {
      return TextFormat.textColor;
    }

    if (attribute is BackgroundAttribute) {
      return TextFormat.highlight;
    }

    return super._getIconForAttribute(attribute);
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
      controller.formatSelection(Attribute.clone(attribute, null));
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

enum ListType { bullet, numbered, quote }

class StyleGroupButton extends StyleButton {
  final AttributeGroupValue attributeGroup;

  StyleGroupButton(
      {required super.attribute,
      required super.controller,
      required this.attributeGroup,
      super.key}) {
    attributeGroup.addListener(() {
      updateGroupSelection();
    });
  }

  @override
  void _updateSelected() {
    bool isSelected = attributeGroup.contains(attribute);

    if (isSelected) {
      // remove it
      attributeGroup.unselect(attribute);
    } else {
      attributeGroup.select(attribute);
    }
  }

  void updateGroupSelection() {
    bool isSelected = attributeGroup.contains(attribute);

    _isSelected.value = isSelected;
  }
}

class StyleListButton extends StyleGroupButton {
  final ListType listType;

  StyleListButton({
    required super.attribute,
    required super.controller,
    required this.listType,
    required super.attributeGroup,
    super.key,
  });

  @override
  String _getIconForAttribute(Attribute attribute) {
    if (attribute is ListAttribute) {
      switch (listType) {
        case ListType.bullet:
          return TextFormat.bullet;
        case ListType.numbered:
          return TextFormat.numbered;
        case ListType.quote:
          return TextFormat.quote;
      }
    }
    return super._getIconForAttribute(attribute);
  }
}

enum AlignType { left, right, center, justify }

class StyleAlignButton extends StyleGroupButton {
  final AlignType alignType;

  StyleAlignButton(
      {required super.attribute,
      required super.controller,
      required this.alignType,
      required super.attributeGroup,
      super.key});

  @override
  String _getIconForAttribute(Attribute attribute) {
    if (attribute is AlignAttribute) {
      switch (alignType) {
        case AlignType.center:
          return TextFormat.alignCenter;
        case AlignType.justify:
          return TextFormat.alignJustify;
        case AlignType.left:
          return TextFormat.alignLeft;
        case AlignType.right:
          return TextFormat.alignRight;
      }
    }
    return super._getIconForAttribute(attribute);
  }
}
