import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  ThemeData set() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF794CFF),
        secondary: Color(0xFF5C0AFF),
        shadow: Color(0xFF5C0AFF),
        background: Color(0xFFF3F5F8),
        onPrimary: Color(0xFFF3F5F8),
        onSecondary: Color(0xFFF3F5F8),
        onBackground: Color(0xFF1D2830),
        onTertiary: Color(0xFFAFBED0),
        onSurface: Color(0xFF1D2830),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}
