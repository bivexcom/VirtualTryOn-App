import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Custom theme extension for semantic color access
/// Provides easy access to neutral surfaces and peach accents
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  // Neutral surfaces
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  
  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  
  // Peach accents
  final Color primaryPeach;
  final Color primarySoft;
  final Color primaryDark;
  
  // Icon colors
  final Color iconNeutral;
  
  // Gradients
  final Gradient peachGradient;
  final Gradient subtleGradient;
  
  // Shadow
  final Color shadow;

  const AppThemeExtension({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryPeach,
    required this.primarySoft,
    required this.primaryDark,
    required this.iconNeutral,
    required this.peachGradient,
    required this.subtleGradient,
    required this.shadow,
  });

  /// Light theme extension - Neutral base
  static const AppThemeExtension light = AppThemeExtension(
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceVariant: AppColors.surfaceVariant,
    border: AppColors.border,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    primaryPeach: AppColors.primaryPeach,
    primarySoft: AppColors.primarySoft,
    primaryDark: AppColors.primaryDark,
    iconNeutral: AppColors.iconNeutral,
    peachGradient: LinearGradient(
      colors: AppColors.peachGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    subtleGradient: LinearGradient(
      colors: AppColors.subtlePeachGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    shadow: AppColors.shadow,
  );

  /// Dark theme extension - Cool-neutral base
  static const AppThemeExtension dark = AppThemeExtension(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    border: AppColors.darkBorder,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    primaryPeach: AppColors.primaryPeach,
    primarySoft: AppColors.primarySoft,
    primaryDark: AppColors.primaryDark,
    iconNeutral: Color(0xFFC7C7C9), // Adjusted for dark mode
    peachGradient: LinearGradient(
      colors: AppColors.peachGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    subtleGradient: LinearGradient(
      colors: AppColors.subtlePeachGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    shadow: AppColors.darkShadow,
  );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? primaryPeach,
    Color? primarySoft,
    Color? primaryDark,
    Color? iconNeutral,
    Gradient? peachGradient,
    Gradient? subtleGradient,
    Color? shadow,
  }) {
    return AppThemeExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      primaryPeach: primaryPeach ?? this.primaryPeach,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryDark: primaryDark ?? this.primaryDark,
      iconNeutral: iconNeutral ?? this.iconNeutral,
      peachGradient: peachGradient ?? this.peachGradient,
      subtleGradient: subtleGradient ?? this.subtleGradient,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      primaryPeach: Color.lerp(primaryPeach, other.primaryPeach, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      iconNeutral: Color.lerp(iconNeutral, other.iconNeutral, t)!,
      peachGradient: Gradient.lerp(peachGradient, other.peachGradient, t)!,
      subtleGradient: Gradient.lerp(subtleGradient, other.subtleGradient, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

/// Extension to easily access AppThemeExtension from BuildContext
extension ThemeExtensionGetter on BuildContext {
  AppThemeExtension get appColors =>
      Theme.of(this).extension<AppThemeExtension>() ?? AppThemeExtension.light;
}
