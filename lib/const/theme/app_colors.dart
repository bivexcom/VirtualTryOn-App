import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  AppColors._();

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FA);
  static const Color lightSurfaceVariant = Color(0xFFEEF0F2);
  static const Color lightPrimary = Color(0xFFE91E63); // Pink
  static const Color lightSecondary = Color(0xFF9C27B0); // Purple
  static const Color lightTertiary = Color(0xFF2196F3); // Blue
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF2C2C2C);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0A0A0F);
  static const Color darkSurface = Color(0xFF101015);
  static const Color darkSurfaceVariant = Color(0xFF1A1A20);
  static const Color darkPrimary = Color(0xFFFF4081); // Bright Pink
  static const Color darkSecondary = Color(0xFFAB47BC); // Light Purple
  static const Color darkTertiary = Color(0xFF42A5F5); // Light Blue
  static const Color darkOnBackground = Color(0xFFE8E8E8);
  static const Color darkOnSurface = Color(0xFFD0D0D0);
  static const Color darkBorder = Color(0xFF2A2A30);

  // Gradient Colors
  static const List<Color> gradientPinkPurple = [
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
  ];

  static const List<Color> gradientPinkBlue = [
    Color(0xFFE91E63),
    Color(0xFF2196F3),
  ];

  static const List<Color> gradientPurpleBlue = [
    Color(0xFF9C27B0),
    Color(0xFF2196F3),
  ];

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors
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
