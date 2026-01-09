import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unit_converter/core/theme/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryLight,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textLight,
    error: AppColors.error,
  ),
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: AppColors.textLight,
    displayColor: AppColors.textLight,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    foregroundColor: AppColors.textLight,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.inter(
      color: AppColors.textLight,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.surfaceLight,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
