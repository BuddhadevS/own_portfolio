import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';

class TextStyles {
  static TextStyle get consoleHeader => GoogleFonts.syne(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.5,
  );

  static TextStyle get consoleSubHeader => GoogleFonts.syne(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.appAccentColor,
    letterSpacing: -0.3,
  );

  static TextStyle get consoleBody => GoogleFonts.outfit(
    fontSize: 18,
    height: 1.6,
    color: AppColors.secondaryText,
  );

  static TextStyle get consoleFooter => GoogleFonts.outfit(
    fontSize: 16,
    color: AppColors.mutedText,
  );

  static TextStyle get profileName => GoogleFonts.syne(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: -1.2,
    height: 1.05,
  );

  static TextStyle get profileNameMobile => GoogleFonts.syne(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: -0.8,
    height: 1.08,
  );

  static TextStyle get profileSubtitle => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.appAccentColor,
    letterSpacing: 0.2,
  );

  static TextStyle get profileSubtitleMobile => GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.appAccentColor,
    letterSpacing: 0.15,
  );

  static TextStyle get sectionTitle => GoogleFonts.syne(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.4,
  );

  static TextStyle get sectionTitleMobile => GoogleFonts.syne(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.3,
  );

  static TextStyle get sectionDescription => GoogleFonts.outfit(
    fontSize: 16,
    color: AppColors.secondaryText,
    height: 1.65,
  );

  static TextStyle get sectionDescriptionMobile => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  static TextStyle get cardTitle => GoogleFonts.syne(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.2,
  );

  static TextStyle get cardTitleMobile => GoogleFonts.syne(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );

  static TextStyle get cardDescription => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.secondaryText,
    height: 1.5,
  );

  static TextStyle get cardDescriptionMobile => GoogleFonts.outfit(
    fontSize: 13,
    color: AppColors.secondaryText,
    height: 1.45,
  );

  static TextStyle get skillName => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle get skillNameMobile => GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle get skillPercentage => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedText,
  );

  static TextStyle get skillPercentageMobile => GoogleFonts.outfit(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedText,
  );

  static TextStyle get buttonText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonTextSmall => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get formLabel => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle get formInput => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static TextStyle get formHint => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.mutedText,
  );

  static TextStyle get formError => GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );

  static TextStyle get chatTitle => GoogleFonts.syne(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );

  static TextStyle get chatQuestion => GoogleFonts.outfit(
    fontSize: 15,
    color: AppColors.primaryText,
  );

  static TextStyle get chatMessage => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.primaryText,
    height: 1.45,
  );

  static TextStyle get chatInput => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static TextStyle get chatError => GoogleFonts.outfit(
    fontSize: 12,
    color: AppColors.errorColor,
  );

  static TextStyle get chipText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static TextStyle get chipTextMobile => GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static TextStyle get successText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.successColor,
  );

  static TextStyle get warningText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningColor,
  );

  static TextStyle get errorText => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );

  static TextStyle get heroTitle => GoogleFonts.syne(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: -1.5,
    height: 1.02,
  );

  static TextStyle get heroSubtitle => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.45,
  );

  static TextStyle getResponsiveTextStyle(
    double width, {
    required TextStyle desktop,
    required TextStyle mobile,
  }) {
    return width > 600 ? desktop : mobile;
  }
}
