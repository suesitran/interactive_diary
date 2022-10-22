import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

part 'nartus_color.dart';
part 'nartus_text_theme.dart';
part 'nartus_card_theme.dart';

ThemeData lightTheme = ThemeData(
    errorColor: NartusColor.red,
    textTheme: textTheme,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    colorScheme: lightColorScheme,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
cardTheme: cardTheme);
