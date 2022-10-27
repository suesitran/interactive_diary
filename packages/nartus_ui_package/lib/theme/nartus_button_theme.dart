part of 'nartus_theme.dart';

final ElevatedButtonThemeData primaryButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(_titleMedium),
    shape: const MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(999)))),
    backgroundColor:
        MaterialStateColor.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        // disabled color
        return NartusColor.grey.withOpacity(0.5);
      }
      // hover and default share the same background color
      return NartusColor.primary;
    }),
  ),
);

final OutlinedButtonThemeData secondaryButtonThemeData =
    OutlinedButtonThemeData(
        style: ButtonStyle(
  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
  textStyle: const MaterialStatePropertyAll<TextStyle>(_titleMedium),
  shape: const MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(999)),
  )),
  side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return const BorderSide(color: NartusColor.grey, width: 1);
    }
    return const BorderSide(
      color: NartusColor.primary,
      width: 1,
    );
  }),
));

const TextButtonThemeData textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
      textStyle: MaterialStatePropertyAll<TextStyle>(_titleMedium),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(999))))),
);
