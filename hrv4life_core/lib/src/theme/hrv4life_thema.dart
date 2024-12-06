import 'package:flutter/material.dart';

final class Hrv4lifeThema {
  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.black26));

  static final ligthTheme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Quicksand',
        color: Colors.black38,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Quicksand',
        color: Colors.black38,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red)),
      focusedErrorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
  static final darkTheme = ligthTheme;

  static const titleStyle = TextStyle(
    fontSize: 28,
    height: 1.2,
    fontFamily: 'Montserrat',
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static const subTitleStyle = TextStyle(
      fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
}
