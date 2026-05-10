import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const primary = Color(0xFFFF921C);
  static const secondary = Color(0xFF015B5C);

  static const ink = Color(0xFF0A1A1A);
  static const paper = Color(0xFFF6FAFA);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFD4E8E8);
  static const muted = Color(0xFF527070);
  static const surface = Color(0xFFEAF3F3);
  static const darkTeal = Color(0xFF013E3F);
  static const lightOrange = Color(0xFFFFF1E0);
  static const lightTeal = Color(0xFFDFF0F0);
  static const orangeMuted = Color(0xFFFFD4A0);
}

abstract final class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.card,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.ink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.secondary,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: GoogleFonts.dmSansTextTheme().copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 34, fontWeight: FontWeight.w700,
            color: Colors.white, height: 1.1,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.ink,
          ),
          displaySmall: GoogleFonts.playfairDisplay(
            fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink,
          ),
          titleLarge: GoogleFonts.playfairDisplay(
            fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink,
          ),
          titleMedium: GoogleFonts.dmSans(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink,
          ),
          bodyMedium: GoogleFonts.dmSans(
            fontSize: 13, color: AppColors.muted, height: 1.6,
          ),
          labelSmall: GoogleFonts.dmSans(
            fontSize: 10, letterSpacing: 1.2,
            fontWeight: FontWeight.w500, color: AppColors.muted,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
            textStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white38),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            textStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      );
}
