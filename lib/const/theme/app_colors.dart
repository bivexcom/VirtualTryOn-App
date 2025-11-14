import 'package:flutter/material.dart';

/// App color palette - Neutral Base + Peach Accent
/// Premium, sophisticated palette with cool-neutral surfaces and warm peach accents
/// Peach is used ONLY for highlights, not backgrounds
class AppColors {
  AppColors._();

  // === LIGHT MODE - Neutral Base ===
  static const Color background = Color(0xFFF7F6F4); // Cool neutral background
  static const Color surface = Color(0xFFF0EEEB); // Neutral surface
  static const Color surfaceVariant = Color(0xFFE6E3E0); // Surface variant
  static const Color border = Color(0xFFD7D3D0); // Neutral border
  static const Color textPrimary = Color(0xFF2E2B2B); // Primary text
  static const Color textSecondary = Color(0xFF6B6565); // Secondary text
  static const Color iconNeutral = Color(0xFF7A7472); // Neutral icons
  static const Color shadow = Color(0x0F000000); // rgba(0,0,0,0.06)

  // === ACCENTS - Peach (Highlights Only) ===
  static const Color primaryPeach = Color(0xFFE8A98F); // Primary peach accent
  static const Color primarySoft = Color(0xFFF3D4C6); // Soft peach
  static const Color primaryDark = Color(0xFFC9896F); // Dark peach

  // === DARK MODE - Cool Neutral ===
  static const Color darkBackground = Color(0xFF121214); // Deep cool background
  static const Color darkSurface = Color(0xFF1C1C1F); // Cool surface
  static const Color darkSurfaceVariant = Color(0xFF252529); // Surface variant
  static const Color darkBorder = Color(0xFF3A3A40); // Dark border
  static const Color darkTextPrimary = Color(0xFFF5F4F3); // Light text
  static const Color darkTextSecondary = Color(0xFFC7C7C9); // Secondary text
  static const Color darkShadow = Color(0x1A000000); // Dark shadow

  // === Legacy Mappings for Light Theme ===
  static const Color lightPrimary = primaryPeach;
  static const Color lightSecondary = primarySoft;
  static const Color lightBackground = background;
  static const Color lightSurface = surface;
  static const Color lightSurfaceVariant = surfaceVariant;
  static const Color lightOnBackground = textPrimary;
  static const Color lightOnSurface = textPrimary;
  static const Color lightBorder = border;

  // === Legacy Mappings for Dark Theme ===
  static const Color darkPrimary = primaryPeach;
  static const Color darkSecondary = primarySoft;
  static const Color darkOnBackground = darkTextPrimary;
  static const Color darkOnSurface = darkTextPrimary;

  // === Gradient - Peach Accent (for CTAs ONLY) ===
  static const List<Color> peachGradient = [
    primaryPeach, // #E8A98F
    primarySoft, // #F3D4C6
  ];

  static const List<Color> peachGradientReverse = [
    primarySoft, // #F3D4C6
    primaryPeach, // #E8A98F
  ];

  static const List<Color> subtlePeachGradient = [
    primarySoft, // #F3D4C6
    Color(0xFFF8E5DA), // Very soft peach
  ];

  // === Semantic Colors ===
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // === Neutral Grays ===
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
}
