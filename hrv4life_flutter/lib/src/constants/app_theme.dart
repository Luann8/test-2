import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/extensions/color_extension.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: AppColors.primary.toMaterialColor(),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primary),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColors.primary,
          cursorColor: AppColors.primary,
          selectionColor: AppColors.primary.withOpacity(0.2),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.grey, letterSpacing: 0.4),
          displayMedium: TextStyle(color: AppColors.grey, letterSpacing: 0.4),
          bodyMedium: TextStyle(color: AppColors.grey, letterSpacing: 0.4),
          titleMedium: TextStyle(color: AppColors.grey, letterSpacing: 0.4),
        ),
      ).copyWith(
        scaffoldBackgroundColor: AppColors.lightGreen2,
        canvasColor: AppColors.primary,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: AppColors.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          isDense: false,
          prefixIconColor: AppColors.grey,
          labelStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(
            color: AppColors.grey.withOpacity(0.3),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: AppColors.grey.withOpacity(0.3),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: AppColors.grey.withOpacity(0.3),
            ),
          ),
          //DISABLE  ------
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: AppColors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          //ERROR  ------
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),

          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
        ),
      );
}
