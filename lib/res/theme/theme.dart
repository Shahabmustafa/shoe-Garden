import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTheme {
  TTheme._();

  static ThemeData lightTheme = ThemeData(
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      contentTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedTextColor: Colors.white,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff13132a),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff13132a),
      centerTitle: true,
    ),
    useMaterial3: false,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Color(0xff13132a),
      suffixIconColor: Color(0xff13132a),
      labelStyle: GoogleFonts.lato(
        color: Color(0xff13132a),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      border: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color(0xff13132a),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color(0xff13132a),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color(0xff13132a),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Color(0xff13132a),
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          side: const BorderSide(
            color: Colors.black,
          ),
          minimumSize: Size(100, 40), // Set width and height
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    ),
  );
}
