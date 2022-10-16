import 'package:flutter/material.dart';

import 'nartus_color.dart';
import 'nartus_text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  errorColor: NartusColor.red,
  textTheme: textTheme,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  colorScheme: lightColorScheme,
  fontFamily: GoogleFonts.plusJakartaSans().fontFamily
);

