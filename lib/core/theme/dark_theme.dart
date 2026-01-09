import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unit_converter/core/theme/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textDark,
    error: AppColors.error,
  ),
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
    bodyColor: AppColors.textDark,
    displayColor: AppColors.textDark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textDark,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.inter(
      color: AppColors.textDark,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.surfaceDark,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
