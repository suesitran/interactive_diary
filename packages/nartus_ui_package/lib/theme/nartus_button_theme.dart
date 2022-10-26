part of 'nartus_theme.dart';

const ElevatedButtonThemeData primaryButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
        textStyle: MaterialStatePropertyAll<TextStyle>(_titleMedium),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(999))
      ))
    ),);
