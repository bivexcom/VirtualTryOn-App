import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'theme_extensions.dart';

/// Dark theme configuration - Cool-Neutral Base + Peach Accent
/// Premium cool-neutral dark palette with warm peach accents
/// No warm browns - only cool-neutral charcoal/gray surfaces
/// Peach is used ONLY for highlights, never for backgrounds
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  // Color Scheme - Cool-Neutral Dark with Peach Accent
  colorScheme: const ColorScheme.dark(
    // Peach accents (slightly desaturated for dark mode)
    primary: AppColors.primaryPeach, // #E8A98F
    primaryContainer: AppColors.darkSurfaceVariant,
    secondary: AppColors.primarySoft,
    secondaryContainer: AppColors.darkSurfaceVariant,
    tertiary: AppColors.primaryDark,
    
    // Cool-neutral surfaces
    surface: AppColors.darkSurface, // #1C1C1F
    surfaceVariant: AppColors.darkSurfaceVariant, // #252529
    surfaceTint: Colors.transparent, // No tint
    background: AppColors.darkBackground, // #121214
    
    // Semantic colors
    error: AppColors.error,
    
    // On colors
    onPrimary: AppColors.white,
    onSecondary: AppColors.darkTextPrimary,
    onSurface: AppColors.darkTextPrimary, // #F5F4F3
    onBackground: AppColors.darkTextPrimary,
    onError: AppColors.white,
    
    // Borders
    outline: AppColors.darkBorder, // #3A3A40
    outlineVariant: AppColors.darkSurfaceVariant,
  ),

  // Custom Theme Extension
  extensions: const <ThemeExtension<dynamic>>[
    AppThemeExtension.dark,
  ],

  // Scaffold - Cool-neutral background
  scaffoldBackgroundColor: AppColors.darkBackground,

  // AppBar - Cool-neutral
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkTextPrimary,
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.primarySoft.withOpacity(0.85)),
    actionsIconTheme: IconThemeData(color: AppColors.primarySoft.withOpacity(0.85)),
  ),

  // Card - Cool-neutral surface
  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 4,
    shadowColor: AppColors.darkShadow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: AppColors.darkBorder.withOpacity(0.5),
        width: 1,
      ),
    ),
  ),

  // Elevated Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryPeach,
      foregroundColor: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.primaryPeach.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  ),

  // Text Button
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryPeach,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),

  // Outlined Button - Neutral border
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.darkTextPrimary,
      side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  ),

  // Filled Button - Peach accent
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primaryPeach,
      foregroundColor: AppColors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  ),

  // Icon Button - Soft peach for dark mode
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.primarySoft.withOpacity(0.85),
    ),
  ),

  // Input Decoration - Cool-neutral
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurfaceVariant,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryPeach, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    hintStyle: TextStyle(color: AppColors.darkTextSecondary),
    labelStyle: TextStyle(color: AppColors.darkTextSecondary),
  ),

  // Divider - Cool-neutral border
  dividerTheme: const DividerThemeData(
    color: AppColors.darkBorder,
    thickness: 1,
    space: 1,
  ),

  // Bottom Navigation Bar - Cool surface, peach active
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primaryPeach,
    unselectedItemColor: AppColors.primarySoft.withOpacity(0.85),
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),

  // Icon Theme - Soft peach for dark mode
  iconTheme: IconThemeData(
    color: AppColors.primarySoft.withOpacity(0.85),
  ),

  // Primary Icon Theme - Peach
  primaryIconTheme: const IconThemeData(
    color: AppColors.primaryPeach,
  ),

  // Tab Bar Theme - Cool-neutral with peach active
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.darkTextPrimary,
    unselectedLabelColor: AppColors.darkTextSecondary,
    indicator: BoxDecoration(
      color: AppColors.primaryPeach,
      borderRadius: BorderRadius.circular(12),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  ),

  // Chip Theme - Cool-neutral background, peach active
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.darkSurfaceVariant,
    selectedColor: AppColors.primaryPeach.withOpacity(0.2),
    labelStyle: const TextStyle(color: AppColors.darkTextPrimary),
    secondaryLabelStyle: const TextStyle(color: AppColors.darkTextPrimary),
    side: BorderSide(color: AppColors.darkBorder),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),

  // Switch Theme - Peach active
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.white;
      }
      return AppColors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryPeach;
      }
      return AppColors.darkBorder;
    }),
  ),

  // Progress Indicator - Peach
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryPeach,
    linearTrackColor: AppColors.darkSurfaceVariant,
    circularTrackColor: AppColors.darkSurfaceVariant,
  ),

  // Slider Theme - Peach
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primaryPeach,
    inactiveTrackColor: AppColors.darkSurfaceVariant,
    thumbColor: AppColors.primaryPeach,
    overlayColor: AppColors.primaryPeach.withOpacity(0.12),
  ),

  // Text Theme - Cool-neutral text
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
    bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
    bodySmall: TextStyle(color: AppColors.darkTextSecondary),
    labelLarge: TextStyle(color: AppColors.darkTextPrimary),
    labelMedium: TextStyle(color: AppColors.darkTextSecondary),
    labelSmall: TextStyle(color: AppColors.darkTextSecondary),
    titleLarge: TextStyle(color: AppColors.darkTextPrimary),
    titleMedium: TextStyle(color: AppColors.darkTextPrimary),
    titleSmall: TextStyle(color: AppColors.darkTextPrimary),
    headlineLarge: TextStyle(color: AppColors.darkTextPrimary),
    headlineMedium: TextStyle(color: AppColors.darkTextPrimary),
    headlineSmall: TextStyle(color: AppColors.darkTextPrimary),
  ).apply(
    bodyColor: AppColors.darkTextPrimary,
    displayColor: AppColors.darkTextPrimary,
  ),
);
