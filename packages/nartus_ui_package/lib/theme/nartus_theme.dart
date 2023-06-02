import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

part 'nartus_color.dart';
part 'nartus_text_theme.dart';
part 'nartus_card_theme.dart';
part 'nartus_button_theme.dart';
part 'nartus_bottom_sheet_theme_data.dart';

ThemeData lightTheme = ThemeData(
    textTheme: textTheme,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    cardTheme: cardTheme,
    elevatedButtonTheme: primaryButtonThemeData,
    outlinedButtonTheme: secondaryButtonThemeData,
    textButtonTheme: textButtonThemeData,
    colorScheme: lightColorScheme,
    bottomSheetTheme: bottomSheetThemeData);
