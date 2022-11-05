part of 'nartus_button.dart';

/// button style for image only
const ButtonStyle _iconOnlyButtonStyleLarge = ButtonStyle(
    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.all(NartusDimens.padding16)),
    minimumSize: MaterialStatePropertyAll<Size>(
        Size(NartusDimens.padding52, NartusDimens.padding52)));

const ButtonStyle _iconOnlyButtonStyleSmall = ButtonStyle(
    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.all(NartusDimens.padding12)),
    minimumSize: MaterialStatePropertyAll<Size>(
        Size(NartusDimens.padding44, NartusDimens.padding44)));

/// button style for small button - 44px
final ButtonStyle _buttonStyleTextSmall = ButtonStyle(
  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(
          vertical: NartusDimens.padding10,
          horizontal: NartusDimens.padding20)),
  textStyle: MaterialStatePropertyAll<TextStyle?>(textTheme.titleSmall),
  minimumSize: const MaterialStatePropertyAll<Size>(
      Size(NartusDimens.padding44, NartusDimens.padding44)),
);
