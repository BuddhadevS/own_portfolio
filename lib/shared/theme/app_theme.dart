import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';

class AppTheme {
  static String get displayFontFamily => GoogleFonts.syne().fontFamily!;
  static String get bodyFontFamily => GoogleFonts.outfit().fontFamily!;

  /// Kept for call sites that still read AppTheme.fontFamily
  static String get fontFamily => bodyFontFamily;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: bodyFontFamily,

    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.appAccentColor,
      onPrimary: AppColors.pureWhite,
      secondary: AppColors.mediumAccent,
      onSecondary: AppColors.pureWhite,
      tertiary: AppColors.secondaryText,
      onTertiary: AppColors.pureWhite,
      surface: AppColors.cardBackground,
      onSurface: AppColors.primaryText,
      surfaceContainerHighest: AppColors.surfaceColor,
      surfaceContainer: AppColors.secondaryBackground,
      surfaceContainerLow: AppColors.cardBackground,
      outline: AppColors.borderColor,
      outlineVariant: AppColors.lightBorder,
      inversePrimary: AppColors.pureWhite,
      inverseSurface: AppColors.pureBlack,
      onInverseSurface: AppColors.pureWhite,
      error: AppColors.errorColor,
      onError: AppColors.pureWhite,
      scrim: AppColors.pureBlack,
      shadow: AppColors.pureBlack,
    ),

    primaryColor: AppColors.appAccentColor,
    primaryColorDark: AppColors.appAccentColor,
    primaryColorLight: AppColors.mediumAccent,

    scaffoldBackgroundColor: AppColors.primaryBackground,
    canvasColor: AppColors.secondaryBackground,
    cardColor: AppColors.cardBackground,
    dividerColor: AppColors.borderColor,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBackground.withValues(alpha: 0.92),
      foregroundColor: AppColors.primaryText,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.syne(
        color: AppColors.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.primaryBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),

    textTheme: GoogleFonts.outfitTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.55,
        ),
        bodyMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: AppColors.mutedText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: AppColors.mutedText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appAccentColor,
        foregroundColor: AppColors.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        side: const BorderSide(color: AppColors.lightBorder, width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.appAccentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),
    primaryIconTheme: const IconThemeData(
      color: AppColors.pureWhite,
      size: 24,
    ),

    cardTheme: const CardThemeData(
      color: AppColors.cardBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      margin: EdgeInsets.all(0),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.appAccentColor, width: 2),
      ),
      labelStyle: GoogleFonts.outfit(color: AppColors.secondaryText),
      hintStyle: GoogleFonts.outfit(color: AppColors.mutedText),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.appAccentColor,
      foregroundColor: AppColors.pureWhite,
      elevation: 2,
      shape: CircleBorder(),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.borderColor,
      thickness: 1,
      space: 1,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.accentSoft,
      deleteIconColor: AppColors.secondaryText,
      disabledColor: AppColors.surfaceColor,
      selectedColor: AppColors.appAccentColor,
      secondarySelectedColor: AppColors.mediumAccent,
      labelStyle: GoogleFonts.outfit(color: AppColors.primaryText),
      secondaryLabelStyle: GoogleFonts.outfit(color: AppColors.pureWhite),
      brightness: Brightness.light,
      elevation: 0,
      pressElevation: 0,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.appAccentColor,
      unselectedItemColor: AppColors.mutedText,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.pureBlack,
      contentTextStyle: GoogleFonts.outfit(color: AppColors.pureWhite),
      actionTextColor: AppColors.mediumAccent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 4,
    ),
  );
}
