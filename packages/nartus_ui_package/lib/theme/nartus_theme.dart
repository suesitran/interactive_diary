import 'package:flutter/material.dart';

import 'package:nartus_ui_package/theme/nartus_color.dart';
import 'package:nartus_ui_package/theme/nartus_text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  errorColor: NartusColor.red,
  textTheme: textTheme,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  colorScheme: lightColorScheme,
  fontFamily: GoogleFonts.plusJakartaSans().fontFamily
);

